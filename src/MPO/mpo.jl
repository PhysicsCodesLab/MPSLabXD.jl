#mpo.jl
struct ModelMPO{S<:EuclideanSpace} <: AbstractMPS{S}
    Ws::Vector{<:AbstractTensorMap{S, 2, 2}}
    function ModelMPO{S}(Ws::Vector{<:AbstractTensorMap{S, 2, 2}}) where {S<:EuclideanSpace}
        new(Ws)
    end
end

"""
    function TransverseFieldIsing(N::Int)

``H = - J ∑_i σˣ_i σˣ_{i+1}  - g ∑_i σᶻ_i``
"""
function TransverseFieldIsing(N::Int)
    chi_virtual = 3
    chi_physical = 2
    W_virtual = ℂ^chi_virtual
    W_physical = ℂ^chi_physical
    data = zeros(chi_virtual,chi_physical,chi_virtual,chi_physical)
    Id = [1 0; 0 1]
    sigmax = [0 1; 1 0]
    sigmay = [0 -1im; 1im 0]
    sigmaz = [1 0; 0 -1]
    data[1,:,:,1] = Id
    data[2,:,:,1] = sigmax
    data[3,:,:,1] = sigmaz
    data[3,:,:,2] = sigmax
    data[3,:,:,3] = Id
    W = TensorMap(data, W_virtual ⊗ W_physical, W_physical ⊗ W_virtual)
    return ModelMPO{ComplexSpace}(append!([[W] for i in 1:N]...))
end
