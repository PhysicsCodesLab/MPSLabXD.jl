#finitemps.jl
struct FiniteMPS{S<:EuclideanSpace} <: AbstractMPS{S}
    Ts::Vector{<:AbstractTensorMap{S, 2, 1}}
    Ss::Vector{<:Union{AbstractTensorMap{S,1,1},Nothing}}
    canonical_form::Vector{Symbol}
    function FiniteMPS{S}(Ts::Vector{<:AbstractTensorMap{S, 2, 1}},
                            Ss::Vector{<:Union{AbstractTensorMap{S,1,1},Nothing}},
                            canonical_form::Vector{Symbol}) where {S<:EuclideanSpace}
        (dim(space(Ts[1],1)) == 1 && dim(space(Ts[end],3)) == 1) ||
            error("The left bond of the first tensor and the right bonnd of the
                    last tensor should have dimension 1 for finite MPS!")
        canonical_form[1] ∈ [:left_canonical,:right_canonical,:site_canonical,
                                :bond_canonical,:GammaLambda_canonical,:non_canonical] ||
            error("There is no such canonical form!")
        for i in 1:length(Ts)-1
            space(Ts[i],3) == dual(space(Ts[i+1],1)) ||
                error("The contracted spaces of tensors do not match!")
        end
        new(Ts,Ss,canonical_form)
    end
end

FiniteMPS(Ts,Ss,canonical_form) = FiniteMPS{spacetype(Ts[1])}(Ts, Ss, canonical_form)

function make_left_canonical(mps::FiniteMPS)
    if mps.canonical_form[1] == :GammaLambda_canonical
        error("not implemented yet!")
    end
    if mps.canonical_form[1] == :non_canonical && typeof(mps.Ss) != Vector{Nothing}
        error("not implemented yet!")
    end
    for i in 1:length(mps.Ts)-1
        Q, R = leftorth(mps.Ts[i])
        mps.Ts[i] = Q
        A_tmp = TensorMap(undef, codomain(R)*codomain(mps.Ts[i+1],2), domain(mps.Ts[i+1]))
        @tensor A_tmp[a b;c] = R[a d]*mps.Ts[i+1][d b;c]
        mps.Ts[i+1] = A_tmp
    end
    mps_norm = tr(mps.Ts[L]'*mps.Ts[L])
    mps.Ts[L] = mps.Ts[L]/sqrt(mps_norm)
    mps.canonical_form[1] = :left_canonical
    return
end

function make_right_canonical(mps::FiniteMPS)
    if mps.canonical_form[1] == :GammaLambda_canonical
        error("not implemented yet!")
    end
    if mps.canonical_form[1] == :non_canonical && typeof(mps.Ss) != Vector{Nothing}
        error("not implemented yet!")
    end
    for i in length(mps.Ts):-1:2
        L, Q = rightorth(mps.Ts[i], (1,), (2,3))
        mps.Ts[i] = permute(Q,(1,2),(3,))
        A_tmp = TensorMap(undef, codomain(mps.Ts[i-1]), domain(L))
        @tensor A_tmp[a b;d] = mps.Ts[i-1][a b;c]*L[c;d]
        mps.Ts[i-1] = A_tmp
    end
    T_tmp = TensorMap(undef, codomain(mps.Ts[1],1),codomain(mps.Ts[1],1))
    @tensor T_tmp[a;d] := mps.Ts[1][a b;c]*conj(mps.Ts[1][d b;c])
    mps_norm = tr(T_tmp)
    mps.Ts[1] = mps.Ts[1]/sqrt(mps_norm)
    mps.canonical_form[1] = :right_canonical
    return
end

function LinearAlgebra.norm(mps::FiniteMPS)
    A = mps.Ts[1]'*mps.Ts[1]
    for i in 2:length(mps.Ts)
        A_tmp1 = TensorMap(undef,codomain(A)*codomain(mps.Ts[i],2),domain(mps.Ts[i]))
        @tensor A_tmp1[d b;c] = A[d;a]*mps.Ts[i][a b;c]
        A_tmp2 = TensorMap(undef,domain(mps.Ts[i]),domain(mps.Ts[i]))
        @tensor A_tmp2[d;c] =  conj(mps.Ts[i][a b;d])*A_tmp1[a b;c]
        A = A_tmp2
    end
    return tr(A)
end

function site_canonical(psi::FiniteMPS, n::Int)
end

function bond_canonical(psi::FiniteMPS, b::Int)
end
