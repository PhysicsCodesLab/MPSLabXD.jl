# [Finite Density Renormalization Group](@id s_fDMRG)

DMRG is a variational algorithm to find the low energy states of a given Hamiltonian. The
ansatz is assumed to be in the form of an MPS.

In general, the question is
```math
\begin{aligned}
E(A) = \min_{\{A\}}\frac{⟨ψ(A)|H|ψ(A)⟩}{⟨ψ(A)|ψ(A)⟩}  
\end{aligned}
```

Spirit of DMRG is optimize the local tensors in MPS site by site. Thus it is only local
optimal.
