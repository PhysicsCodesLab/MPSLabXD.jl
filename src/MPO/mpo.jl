#mpo.jl
"""
    struct MPO{S<:EuclideanSpace} <: AbstractMPS{S}

This type include the Hamiltonian and also other operators which are in the form of MPO.
"""
struct MPO{S<:EuclideanSpace} <: AbstractMPS{S}
    Ws::Vector{<:AbstractTensorMap{S, 2, 2}} # codomain= left*down, domain = up*right
    function MPO{S}(Ws::Vector{<:AbstractTensorMap{S, 2, 2}}) where {S<:EuclideanSpace}
        new(Ws)
    end
end

"""
    function TransverseFieldIsing(L::Int,J::Real,g::Real)

``H = - J ∑_i σˣ_i σˣ_{i+1}  - g ∑_i σᶻ_i``
This model has a Z2 symmetry which is ``∏_i σᶻ_i``.
"""
function TransverseFieldIsing(L::Int,J::Real,g::Real)
    V_virtual = ℤ₂Space(0=>3)
    V_physical = ℤ₂Space(0=>1,1=>1)
    chi_virtual = dim(V_virtual)
    chi_physical = dim(V_physical)
    data = zeros(chi_virtual,chi_physical,chi_physical,chi_virtual)
    Id = [1 0; 0 1]
    sigmax = [0 1; 1 0]
    sigmay = [0 -1im; 1im 0]
    sigmaz = [1 0; 0 -1]
    data[1,:,:,1] = Id
    data[2,:,:,1] = -J*sigmax
    data[3,:,:,1] = -g*sigmaz
    data[3,:,:,2] = sigmax
    data[3,:,:,3] = Id
    W = Tensor(data, V_virtual ⊗ V_physical⊗V_physical ⊗ V_virtual)
    return MPO{ℤ₂Space}(append!([[W] for i in 1:L]))
end

"""
    function Heisenberg(N::Int)
"""
function Heisenberg(N::Int)
end
