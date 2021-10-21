# fDMRG_tfIsing.jl
# Using finite DMRG to calculate the ground state energy of TransverseFieldIsing model.

# Step 1: Initialize the MPS
V_virtual = ℤ₂Space(0=>5,1=>5)
V_physical = ℤ₂Space(0=>1,1=>1)
V_boundary = ℤ₂Space(0=>1)
T_left_boundary = TensorMap(randn, V_boundary*V_physical, V_virtual)
T_bulk = TensorMap(randn,V_virtual*V_physical,V_virtual)
T_right_boundary = TensorMap(randn,V_virtual*V_physical,V_boundary)
L = 10
s = [nothing for i in 1:L]
mps = FiniteMPS(append!([T_left_boundary],[T_bulk for i in 1:L-2],
                            [T_right_boundary]),s,[:non_canonical])
make_right_canonical(mps)

# step 2: Define the model Hamiltonian as mpo
J = 1.0
g = 1.0
mpo, final_position = TransverseFieldIsing(L,J,g)

# step 2: Do finite DMRG
DMRG_parameters = Dict("max_E_error"=>10^-8,
                       "max_S_error"=>10^-3,
                       "max_sweep"=>100,
                       "min_sweep"=>5)

truncation_parameters = Dict("chi_max"=>100,
                             "svd_min"=>10^(-10),
                             "truncation_error"=>10^-8)

finiteDMRG(mps, mpo, final_position, DMRG_parameters, truncation_parameters)
