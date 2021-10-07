#finitemps.jl
struct FiniteMPS{S<:IndexSpace} <: AbstractMPS{S}
    Ts::Vector{<:AbstractTensorMap{S, 2, 1}}
    Ss::Vector{Vector{Float64}}
    canonical_form::Vector{Symbol}
    function FiniteMPS{S}(Ts::Vector{<:AbstractTensorMap{S, 2, 1}},
                            Ss::Vector{Vector{Float64}},
                            canonical_form::Vector{Symbol}) where {S<:IndexSpace}
        (dim(space(Ts[1],1)) == 1 && dim(space(Ts[end],3)) == 1) ||
            error("The left bond of the first tensor and the right bonnd of the
                    last tensor should have dimension 1 for finite MPS!")
        canonical_form[1] ∈ [:left,:right,:site,:bond,:Gamma,:non_canonical] ||
            error("There is no such canonical form!")
        new(Ts,Ss,canonical_form)
    end
end

FiniteMPS(Ts,Ss,canonical_form) =
    FiniteMPS{spacetype(Ts[1])}(Ts, Ss, canonical_form)


function make_right_canonical(mps::FiniteMPS)
    L = length(mps.Ts)
    for i in 1:L-1
        Q, R = leftorth(mps.Ts[i])
        mps.Ts[i] = Q
        A = TensorMap(undef,codomain(R)*codomain(mps.Ts[i+1],2),
                            domain(mps.Ts[i+1]))
        @tensor A[a,b;c] = R[a,d]*mps.Ts[i+1][d,b;c]
        mps.Ts[i+1] = A
    end
    mps_norm = LinearAlgebra.tr(mps.Ts[L]'*mps.Ts[L])
    mps.Ts[L] = mps.Ts[L]/sqrt(mps_norm)
    mps.canonical_form[1] = :right
    return
end

function leftcanonical(psi::FiniteMPS)
end

function GammaLamma_canonical(psi::FiniteMPS)

end

function site_canonical(psi::FiniteMPS, n::Int)

end

function bond_canonical(psi::FiniteMPS, b::Int)

end
