# finiteDMRG.jl
function finiteDMRG(mps::FiniteMPS, mpo::MPO, final_position::Int,
                    DMRG_parameters::Dict, truncation_parameters::Dict)
    L = length(mps.Ts)

    if mps.canonical_form[1] != :right_canonical
        make_right_canonical(mps)
    end

    max_sweep = get(DMRG_parameters,"max_sweep",50)
    min_sweep = get(DMRG_parameters,"min_sweep",5)
    max_E_error = get(DMRG_parameters,"max_E_error",10^-8)
    max_S_error = get(DMRG_parameters,"max_S_error",10^-3)

    env = initialize_FiniteEnvironment(mps,mpo,final_position)

    println("Sweep 1")
    E = one_sweep(mps,mpo,env,truncation_parameters)
    chi = get_chi(mps)
    println("chi = ", chi)
    println("E = ", E)
    E_list = [E]
    S = entanglement_entropy(mps)
    println("S = ", S)
    S_list = [S]

    for i in 2:max_sweep
        println("Sweep ", i)
        E = one_sweep(mps,mpo,env,truncation_parameters)
        chi = get_chi(mps)
        println("chi = ", chi)
        println("E = ", E)
        push!(E_list,E)
        delta_E = E_list[end]-E_list[end-1]
        println("delta_E = ", delta_E)
        delta_E > max_E_error*0.1 && error("the energy increases, stop DMRG!")
        -delta_E < max_E_error && println("The energy has converged!")
        S = entanglement_entropy(mps)
        push!(S_list,S)
        delta_S = mapreduce(x->abs(x), +, S_list[end]-S_list[end-1])/L
        println("delta_S = ", delta_S)
        delta_S < max_S_error && println("The entanglement entropy has converged!")
        if (-delta_E < max_E_error) && (delta_S < max_S_error) && (i >= min_sweep)
            println("Both energy and entropy has converged! DMRG finishes!")
            break
        end
        if i == max_sweep
            println("NOTE!!! The maximal number of sweep has been reached, but the
                simulation has not been converged to the given precision!!!")
        end
    end
end

function one_sweep(mps::FiniteMPS,mpo::MPO,env::FiniteEnvironment,
                    truncation_parameters::Dict)
    E_list_one_sweep = [ ]
    truncation_error_list_one_sweep = [ ]

    # sweep from left to right
    for i in 2:length(mps.Ts)
        U, ??, V??, ??, E, info = one_update(i, mps, mpo, env, truncation_parameters)
        push!(E_list_one_sweep, E)
        push!(truncation_error_list_one_sweep, ??)
        mps.Ts[i-1] = U
        mps.Ss[i] = ??
        mps.Ts[i] = permute(??*V??, (1,3),(2,))
        update_left_env(i,mps,mpo,env)
    end

    # sweep from right to left
    for i in length(mps.Ts):-1:2
        U, ??, V??, ??, E, info = one_update(i, mps, mpo, env, truncation_parameters)
        push!(E_list_one_sweep, E)
        push!(truncation_error_list_one_sweep, ??)
        mps.Ts[i-1] = U*??
        mps.Ss[i] = ??
        mps.Ts[i] = permute(V??,(1,3),(2,))
        update_right_env(i,mps,mpo,env)
    end
    println("E_list_one_sweep = ", E_list_one_sweep)
    println("truncation_error_list_one_sweep = ", truncation_error_list_one_sweep)
    return E_list_one_sweep[end]
end

function one_update(i::Int, mps::FiniteMPS, mpo::MPO, env::FiniteEnvironment,
                        truncation_parameters::Dict)
    chi_max = get(truncation_parameters,"chi_max",50)
    svd_min = get(truncation_parameters,"svd_min",10^-10)
    truncation_error = get(truncation_parameters,"truncation_error", 10^-8)

    i > 1 || error("bond should be larger than 1")
    i < length(mps.Ts) + 1 || error("bond should be smaller than the length of mps")

    theta_ini = TensorMap(undef, codomain(mps.Ts[i-1])*codomain(mps.Ts[i],2),
                            domain(mps.Ts[i]))
    @tensor theta_ini[a b d;e] = mps.Ts[i-1][a b;c]*mps.Ts[i][c d;e]

    E, theta_new, info = eigsolve(theta_ini, 1, :SR, Lanczos()) do x
        build_two_site_H_eff(x, mpo.Ws[i-1], mpo.Ws[i],
                                env.left_env[i-1], env.right_env[i+1])
    end
    U, ??, V??, ?? = tsvd(theta_new[1], (1,2), (4,3),
               trunc = truncdim(chi_max) & truncbelow(svd_min) & truncerr(truncation_error),
               p = 2, alg= SDD())
    return U, ??, V??, ??, E[1], info
end


function build_two_site_H_eff(theta::AbstractTensorMap{S,3,1},
                              W1::AbstractTensorMap{S,2,2}, W2::AbstractTensorMap{S,2,2},
                              left_env::AbstractTensorMap{S,1,2},
                              right_env::AbstractTensorMap{S,2,1}) where S
    T_tmp1 = TensorMap(undef, codomain(left_env)*codomain(theta,2)*codomain(theta,3),
                        domain(left_env,2)*domain(theta))
    @tensor T_tmp1[a d e;c f] = left_env[a;b c]*theta[b d e;f]

    T_tmp2 = TensorMap(undef,codomain(left_env)*codomain(theta,3)*codomain(W1,2),
                        domain(theta)*domain(W1,2))
    @tensor T_tmp2[e f b;g d] = T_tmp1[e c f;a g]*W1[a b;c d]

    T_tmp3 = TensorMap(undef,codomain(left_env)*codomain(W1,2)*codomain(W2,2),
                        domain(theta)*domain(W2,2))
    @tensor T_tmp3[e f b;g d] = T_tmp2[e c f;g a]*W2[a b;c d]

    theta_H = TensorMap(undef, codomain(left_env)*codomain(W1,2)*codomain(W2,2),
                            domain(right_env))
    @tensor theta_H[d e f;c] = T_tmp3[d e f;a b]*right_env[a b;c]
    return theta_H
end
