#finiteDMRG.jl
function finiteDMRG(mps::FiniteMPS, mpo::MPO, DMRG_parameters::Dict)
    if mps.canonical_form[1] != :right_canonical
        make_right_canonical(mps)
    end
    chi_max = get(DMRG_parameters,"chi_max",50)
    sweep_max = get(DMRG_parameters,"sweep_max",50)

    env = initialize_FiniteEnv(mps::FiniteMPS,mpo::MPO)
    # use two-site update algorithm

end
