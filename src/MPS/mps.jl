# mps.jl
abstract type AbstractMPS{S<:IndexSpace, L} end

struct FiniteMPS{S <: IndexSpace, L} <: AbstractMPS{S, L}
    sitetensors::NTuple{L, TensorMap{S}}
    schmidtvalues::NTuple{L-1, Vector{Float64}}
    canonical_form::Symbol
    function FiniteMPS{S <: IndexSpace, L}(sitetensors, schmidtvalues = nothing,
                                            canonical_form = :noncanonical)
        (dim(space(sitetensors[1],1)) == 1 && dim(space(sitetensors[L],3)) == 1) ||
            throw(ArgumentError("the left bond the first tensor and the right bond of the
                                    last tensor should be `ProductSpace{S,0}(())`"))
        canonical_form ∈ [:left, :right, :site, :bond, :Gamma, :noncaonical] ||
            throw(ArgumentError("unrecognized canonical_form"))
        new{S,L}(sitetensors,schmidtvalues,canonical_form)
    end
end
FiniteMPS(sitetensors::NTuple{L, TensorMap{S}},
            schmidtvalues::NTuple{L-1,Vector{Float64}} = nothing,
            canonical_form::Symbol = :noncanonical) where {S <: IndexSpace, L} =
    FiniteMPS{S,L}(sitetensors,schmidtvalues,canonical_form)

struct InfiniteMPS{S <: IndexSpace, L} <: AbstractMPS{S, L}
    sitetensors::NTuple{L, TensorMap{S}}
    schmidtvalues::NTuple{L, Vector{Float64}}
    canonical_form::Symbol
    function InfiniteMPS{S <: IndexSpace, L}(sitetensors, schmidtvalues = nothing,
                                                canonical_form = :noncanonical)
        space(sitetensors[1],1) == space(sitetensors[L],3) ||
            throw(ArgumentError("the space of the left bond of the first tensor should
                                    be the same with the space of the right bond of the
                                    last tensor"))
        canonical_form ∈ [:left, :right, :site, :bond, :Gamma, :noncaonical] ||
            throw(ArgumentError("unrecognized canonical_form"))

        new{S,L}(sitetensors,schmidtvalues,canonical_form)
    end
end
InfiniteMPS(sitetensors::NTuple{L, TensorMap{S}},
            schmidtvalues::NTuple{L,Vector{Float64}} = nothing,
            canonical_form::Symbol = :noncanonical) where {S <: IndexSpace, L} =
    InfiniteMPS{S,L}(sitetensors,schmidtvalues,canonical_form)
