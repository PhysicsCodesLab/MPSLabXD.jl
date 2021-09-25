# mps.jl
abstract type AbstractMPS end

struct FiniteMPS <: AbstractMPS
    sitetensors::Vector{Any}
    schmidtvalues::Vector{Vector{Float64}}
    canonical_form::Symbol
    function FiniteMPS(sitetensors,
                        schmidtvalues = nothing,
                        canonical_form = :noncanonical)
        (length(codomain(sitetensors[1])) == 1 && length(domain(sitetensors[end])) == 0)||
            throw(ArgumentError("the left bond the first tensor and the right bond of the
                                    last tensor should be unit simple object"))
        canonical_form ∈ [:left, :right, :site, :bond, :Gamma, :noncanonical] ||
            throw(ArgumentError("unrecognized canonical_form"))
        new(sitetensors,schmidtvalues,canonical_form)
    end
end

struct InfiniteMPS <: AbstractMPS
    sitetensors::Vector{Any}
    schmidtvalues::Vector{Vector{Float64}}
    canonical_form::Symbol
    function InfiniteMPS(sitetensors,
                            schmidtvalues = nothing,
                            canonical_form = :noncanonical)
        space(sitetensors[1],1) == dual(space(sitetensors[end],3)) ||
            throw(ArgumentError("the space of the left bond of the first tensor should
                                    be the same with the space of the right bond of the
                                    last tensor"))
        canonical_form ∈ [:left, :right, :site, :bond, :Gamma, :noncanonical] ||
            throw(ArgumentError("unrecognized canonical_form"))

        new(sitetensors,schmidtvalues,canonical_form)
    end
end

Base.length(psi::AbstractMPS) = length(psi.sitetensors)

Base.getindex(psi::AbstractMPS, i::Integer) = psi.sitetensors[i]

@inline function Base.iterate(psi::AbstractMPS, ::Val{i} = Val(1)) where {i}
    if i > length(psi)
        return nothing
    else
        return psi.sitetensors[i], Val(i+1)
    end
end

Base.indexed_iterate(psi::AbstractMPS, args...) =
    Base.indexed_iterate(psi.sitetensors, args...)

Base.eltype(psi::AbstractMPS) = typeof(psi.sitetensors[1])
