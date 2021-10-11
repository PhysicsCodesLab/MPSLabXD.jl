#finiteEnvironment.jl
# The environment of finite MPS and Hamiltonian.
# can be used to do DMRG or calculating physical observables
"""
    struct FiniteEnvironment{S<:EuclideanSpace}
"""
struct FiniteEnvironment{S<:EuclideanSpace}
    left_Env::Vector{<:AbstractTensorMap{S,1,2}}
    right_Env::Vector{<:AbstractTensorMap{S,2,1}}
end

function initialize_FiniteEnv(mps::FiniteMPS,mpo::MPO)
    spacetype(mps) == spacetype(mpo) || error("mps and mpo must have the same spacetype!")
    mps.canonical_form[1] == :right_canonical ||
        throw(ArgumentError("input mps should be in the right canonical form!"))
    N = length(mps.Ts)
    N == length(mpo.Ws) || error("mps and mpo must have the same length!")
    left_Env = append!([TensorMap(undef, codomain(mps.Ts[i],1),
                            codomain(mps.Ts[i],1)*codomain(mpo.Ws[i],1)) for i in 1:N],
                       [TensorMap(undef, domain(mps.Ts[end]),
                            domain(mps.Ts[end])*domain(mpo.Ws[end],2))])
    right_Env = append!([TensorMap(undef,codomain(mps.Ts[i],1)*codomain(mpo.Ws[i],1),
                            codomain(mps.Ts[i],1)) for i in 1:N],
                        [TensorMap(undef,domain(mps.Ts[end])*domain(mpo.Ws[end],2),
                            domain(mps.Ts[end]))]
    chi_mpo_left_boundary = dim(codomain(mpo.Ws[1],1))
    chi_mpo_right_boundary = dim(domain(mpo.Ws[end],2))
    left_boundary_matrix = zero(1,1,chi_mpo_left_boundary)
    right_boundary_matrix = zero(1,chi_mpo_right_boundary,1)
    left_boundary_matrix[1,1,end] = 1
    right_boundary_matrix[1,1,1] = 1
    left_boundary_tensor = TensorMap(left_boundary_matrix, codomain(mps.Ts[1],1),
                                        codomain(mps.Ts[1],1)*codomain(mpo.Ws[1],1))
    right_boundary_tensor = TensorMap(right_boundary_matrix,
                            domain(mps.Ts[end])*domain(mpo.Ws[end],2),domain(mps.Ts[end]))
    left_Env[1] = left_boundary_tensor
    right_Env[end] = right_boundary_tensor
    for i in N:-1:1
        A_tmp1 = TensorMap(undef, codomain(mps.Ts[i])*codomain(right_Env[i+1],2),
                                    domain(right_Env[i+1]))
        @tensor A_tmp1[d,e,b;c] = mps.Ts[i][d,e;a]*right_Env[i+1][a,b;c]
        A_tmp2 = TensorMap(undef, codomain(mps.Ts[i],1)*codomain(mpo.Ws[i]),
                                    domain(right_Env[i+1]))
        @tensor A_tmp2[a,e,f;d] = mpo.Ws[i][e,f;b,c]*A_tmp1[a,b,c;d]
        @tensor right_Env[i][a,b;e] = A_tmp2[a,b,c;d]*conj(mps.Ts[i][e,c;d])
    return FiniteEnvironment{spacetype(mps)}(left_Env,right_Env)
end
