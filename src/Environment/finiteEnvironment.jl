# finiteEnvironment.jl
# The environment of finite MPS and MPO form of Hamiltonian.
# an be used to do DMRG or calculating physical observables
"""
    struct FiniteEnvironment{S<:EuclideanSpace}
"""
struct FiniteEnvironment{S<:EuclideanSpace}
    left_env::Vector{<:AbstractTensorMap{S,1,2}}
    right_env::Vector{<:AbstractTensorMap{S,2,1}}
end

function initialize_FiniteEnvironment(mps::FiniteMPS, mpo::MPO, final_position::Int)
    spacetype(mps) == spacetype(mpo) || error("mps and mpo must have the same spacetype!")
    mps.canonical_form[1] == :right_canonical ||
        throw(ArgumentError("input mps should be in the right canonical form!"))
    N = length(mps.Ts)
    N == length(mpo.Ws) || error("mps and mpo must have the same length!")
    left_env = append!([TensorMap(undef, codomain(mps.Ts[i],1),
                            codomain(mps.Ts[i],1)*codomain(mpo.Ws[i],1)) for i in 1:N],
                       [TensorMap(undef, domain(mps.Ts[end]),
                            domain(mps.Ts[end])*domain(mpo.Ws[end],2))])
    right_env = append!([TensorMap(undef,codomain(mps.Ts[i],1)*codomain(mpo.Ws[i],1),
                            codomain(mps.Ts[i],1)) for i in 1:N],
                        [TensorMap(undef,domain(mps.Ts[end])*domain(mpo.Ws[end],2),
                            domain(mps.Ts[end]))])
    chi_mpo_left_boundary = dim(codomain(mpo.Ws[1],1))
    chi_mpo_right_boundary = dim(domain(mpo.Ws[end],2))
    left_boundary_matrix = zeros(1,1,chi_mpo_left_boundary)
    right_boundary_matrix = zeros(1,chi_mpo_right_boundary,1)
    left_boundary_matrix[1,1,final_position] = 1
    right_boundary_matrix[1,1,1] = 1
    left_boundary_tensor = TensorMap(left_boundary_matrix, codomain(mps.Ts[1],1),
                                        codomain(mps.Ts[1],1)*codomain(mpo.Ws[1],1))
    right_boundary_tensor = TensorMap(right_boundary_matrix,
                            domain(mps.Ts[end])*domain(mpo.Ws[end],2),domain(mps.Ts[end]))
    left_env[1] = left_boundary_tensor
    right_env[end] = right_boundary_tensor
    env = FiniteEnvironment{spacetype(mps)}(left_env,right_env)
    for i in N:-1:1
        update_right_env(i, mps, mpo, env)
    end
    return env
end

function update_left_env(i::Int, mps::FiniteMPS, mpo::MPO, env::FiniteEnvironment)
    @tensor A_tmp1[c d;b e] := env.left_env[i-1][c;a b]*mps.Ts[i-1][a d e]
    @tensor A_tmp2[a e;d f] := A_tmp1[a b;c d]*mpo.Ws[i-1][c e;b f]
    @tensor env.left_env[i][e;c d] = conj(mps.Ts[i-1][a b;e])*A_tmp2[a b;c d]
end

function update_right_env(i::Int, mps::FiniteMPS, mpo::MPO, env::FiniteEnvironment)
    @tensor A_tmp1[d e b;c] := mps.Ts[i][d e;a]*env.right_env[i+1][a b;c]
    @tensor A_tmp2[a e f;d] := mpo.Ws[i][e f;b c]*A_tmp1[a b c;d]
    @tensor env.right_env[i][a b;e] = A_tmp2[a b c;d]*conj(mps.Ts[i][e c;d])
end
