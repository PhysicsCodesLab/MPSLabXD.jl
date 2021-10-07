# #infinitemps.jl
# struct InfiniteMPS{S<:IndexSpace} <: AbstractMPS{S}
#     sitetensors::Vector{AbstractTensorMap{S, 2, 1}}
#     schmidtvalues::Vector{Vector{Float64}}
#     canonical_form::Symbol
# end
#
# InfiniteMPS(sitetensors,schmidtvalues=nothing,canonical_form=:non_canonical) =
#       InfiniteMPS{spacetype(sitetensors[1])}(sitetensors, schmidtvalues, canonical_form)
