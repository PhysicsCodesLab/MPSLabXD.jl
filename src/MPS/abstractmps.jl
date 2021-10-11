# mps.jl
abstract type AbstractMPS{S<:EuclideanSpace} end

"""
    field(::Type{<:AbstractMPS{S}}) where {S<:EuclideanSpace}
    field(mps::AbstractMPS)

Return the field type over which an MPS instance or type is defined.
"""
TX.field(::Type{<:AbstractMPS{S}}) where {S<:EuclideanSpace} = field(S)
TX.field(mps::AbstractMPS) = field(typeof(mps))

"""
    spacetype(::Type{<:AbstractMPS{S}}) where {S<:EuclideanSpace}
    spacetype(mps::AbstractMPS)

Return the ElementarySpace type associated to an MPS instance or type.
"""
TX.spacetype(::Type{<:AbstractMPS{S}}) where {S<:EuclideanSpace} = S
TX.spacetype(mps::AbstractMPS) = spacetype(typeof(mps))

"""
    sectortype(::Type{<:AbstractMPS{S}}) where {S<:EuclideanSpace}
    sectortype(mps::AbstractMPS) -> Type{<:Sector}

Return the type of sector over which the MPS instance or type is defined.
"""
TX.sectortype(::Type{<:AbstractMPS{S}}) where {S<:EuclideanSpace} = sectortype(S)
TX.sectortype(mps::AbstractMPS) = sectortype(typeof(mps))

"""
    get_chi(mps::AbstractMPS)

Return the bond dimensions of the MPS on bonds 1:N+1.
"""
function get_chi(mps::AbstractMPS)
    chi_list = append!([dim(codomain(mps.Ts[i],1)) for i in 1:length(mps.Ts)],
                        [dim(domain(mps.Ts[end]))])
    return chi_list
end

"""
    entanglement_entropy(mps::AbstractMPS)
"""
function entanglement_entropy(mps::AbstractMPS)
    S_list = [-sum([(mps.Ss[i][j])^2*log((mps.Ss[i][j])^2) for j in 1:length(mps.Ss[i])])
                    for i in 1:length(mps.Ss)]
    return S_list
end

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
