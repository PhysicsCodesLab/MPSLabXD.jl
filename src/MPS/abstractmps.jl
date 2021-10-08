# mps.jl
abstract type AbstractMPS{S<:IndexSpace} end

"""
    field(::Type{<:AbstractMPS{S}}) where {S<:IndexSpace}
    field(mps::AbstractMPS)

Return the field type over which an MPS instance or type is defined.
"""
TX.field(::Type{<:AbstractMPS{S}}) where {S<:IndexSpace} = field(S)
TX.field(mps::AbstractMPS) = field(typeof(mps))

"""
    spacetype(::Type{<:AbstractMPS{S}}) where {S<:IndexSpace}
    spacetype(mps::AbstractMPS)

Return the ElementarySpace type associated to an MPS instance or type.
"""
TX.spacetype(::Type{<:AbstractMPS{S}}) where {S<:IndexSpace} = S
TX.spacetype(mps::AbstractMPS) = spacetype(typeof(mps))

"""
    sectortype(::Type{<:AbstractMPS{S}}) where {S<:IndexSpace}
    sectortype(mps::AbstractMPS) -> Type{<:Sector}

Return the type of sector over which the MPS instance or type is defined.
"""
TX.sectortype(::Type{<:AbstractMPS{S}}) where {S<:IndexSpace} = sectortype(S)
TX.sectortype(mps::AbstractMPS) = sectortype(typeof(mps))

# Base.getindex(mps::AbstractMPS, i::Integer) = mps.sitetensors[i]
#
# @inline function Base.setindex!(mps::AbstractMPS, v, indices::Vararg{Int})
#     data = t[]
#     @boundscheck checkbounds(data, indices...)
#     @inbounds data[indices...] = v
#     return v
#
# @inline function Base.iterate(psi::AbstractMPS, ::Val{i} = Val(1)) where {i}
#     if i > length(psi)
#         return nothing
#     else
#         return psi.sitetensors[i], Val(i+1)
#     end
# end
#
# Base.eltype(psi::AbstractMPS) = eltype(psi.sitetensors[1])
#
# Base.IteratorEltype(::Type{<:AbstractMPS}) = Base.HasEltype()
# Base.IteratorSize(::Type{<:AbstractMPS}) = Base.HasLength()
#
# function Base.hash(psi::AbstractMPS, h::UInt)
#     h = hash(psi.canonical_form,h)
#     h = hash(psi.schmidtvalues, h)
#     h = hash(psi.sitetensors, h)
#     return h
# end
#
# function Base.:(==)(psi1::AbstractMPS, psi2::AbstractMPS)
#     psi1.canonical_form == psi.canonical_form || return false
#     psi1.schmidtvalues == psi.schmidtvalues || return false
#     psi1.sitetensors == psi2.sitetensors || return false
#     return true
# end

# function Base.isapprox(psi1::AbstractMPS, psi2::AbstractMPS;
#                 atol::Real=0, rtol::Real=Base.rtoldefault(eltype(psi1), eltype(psi2), atol))
#     d = mapreduce(norm,+,ntuple(x -> psi1[x]-psi2[x],length(psi1)))
#     if isfinite(d)
#         return d <= max(atol, rtol*max(norm(t1), norm(t2)))
#     else
#         return false
#     end
# end
