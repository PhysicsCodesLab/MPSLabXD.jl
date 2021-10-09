# [Finite DMRG](@id s_fDMRG)

DMRG is a variational algorithm to find the low energy states of a given Hamiltonian. The
ansatz is assumed to be in the form of an MPS.

In general, the question is finding the wave function which minimize the energy
```math
\begin{aligned}
E(A) = \min_{\{A\}}\frac{⟨ψ(A)|H|ψ(A)⟩}{⟨ψ(A)|ψ(A)⟩}  
\end{aligned}
```
where ``\{A\}`` are the local tensors of the MPS that represent the wave function.

It is a highly nonlinear optimization problem which is in general difficult.

The spirit of DMRG is optimizing the local tensors in the MPS site by site. In each step
we get a local optimal point. We swipe across all sites many times and hope to get the
global minimal point.

The minimization problem can be rewritten using the Lagrange multiplier by defining the
functional
```math
\begin{aligned}
E[A,A^{†},λ] = ⟨ψ(A)|H|ψ(A)⟩ - λ(⟨ψ(A)|ψ(A)⟩-1)
\end{aligned}
```

The minimal point satisfy
```math
\begin{aligned}
&\frac{∂E[A,A^{†},λ]}{∂A^{s_i}_{α_iβ_i}} = \frac{∂E[A,A^{†},λ]}{∂(A^{†})^{s_i}_{α_iβ_i}}=0
&\frac{∂E[A,A^{†},λ]}{∂λ} = 0
\end{aligned}
```
