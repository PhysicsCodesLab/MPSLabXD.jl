var documenterSearchIndex = {"docs":
[{"location":"manual/MPO/#s_MPO","page":"Matrix Product Operator","title":"Matrix Product Operator","text":"","category":"section"},{"location":"manual/MPO/","page":"Matrix Product Operator","title":"Matrix Product Operator","text":"All the MPO form of Hamiltonian or operators with a lot of summations are constructed in the way called \"Finite State Machine\".","category":"page"},{"location":"manual/fDMRG/#s_fDMRG","page":"Finite DMRG","title":"Finite DMRG","text":"","category":"section"},{"location":"manual/fDMRG/","page":"Finite DMRG","title":"Finite DMRG","text":"DMRG is a variational algorithm to find the low energy states of a given Hamiltonian. The ansatz is assumed to be in the form of an MPS.","category":"page"},{"location":"manual/fDMRG/","page":"Finite DMRG","title":"Finite DMRG","text":"In general, the question is finding the wave function which minimize the energy","category":"page"},{"location":"manual/fDMRG/","page":"Finite DMRG","title":"Finite DMRG","text":"beginaligned\nE(A) = min_Afracψ(A)Hψ(A)ψ(A)ψ(A)  \nendaligned","category":"page"},{"location":"manual/fDMRG/","page":"Finite DMRG","title":"Finite DMRG","text":"where A are the local tensors of the MPS that represent the wave function.","category":"page"},{"location":"manual/fDMRG/","page":"Finite DMRG","title":"Finite DMRG","text":"It is a highly nonlinear optimization problem which is in general difficult.","category":"page"},{"location":"manual/fDMRG/","page":"Finite DMRG","title":"Finite DMRG","text":"The spirit of DMRG is optimizing the local tensors in the MPS site by site. In each step we get a local optimal point. We swipe across all sites many times and hope to get the global minimal point.","category":"page"},{"location":"manual/fDMRG/","page":"Finite DMRG","title":"Finite DMRG","text":"The minimization problem can be rewritten using the Lagrange multiplier by defining the functional","category":"page"},{"location":"manual/fDMRG/","page":"Finite DMRG","title":"Finite DMRG","text":"beginaligned\nEAA^λ = ψ(A)Hψ(A) - λ(ψ(A)ψ(A)-1)\nendaligned","category":"page"},{"location":"manual/fDMRG/","page":"Finite DMRG","title":"Finite DMRG","text":"The minimal energy point satisfy the saddle point conditions","category":"page"},{"location":"manual/fDMRG/","page":"Finite DMRG","title":"Finite DMRG","text":"beginaligned\nfracEAA^λA^s_i_α_iβ_i = fracEAA^λ(A^)^s_i_α_iβ_i=0\nfracEAA^λλ = 0\nendaligned","category":"page"},{"location":"manual/fDMRG/","page":"Finite DMRG","title":"Finite DMRG","text":"In the site canonical form, this can be done very easily:","category":"page"},{"location":"manual/fDMRG/","page":"Finite DMRG","title":"Finite DMRG","text":"(Image: mps_convention)","category":"page"},{"location":"manual/fDMRG/","page":"Finite DMRG","title":"Finite DMRG","text":"It becomes an eigenvalue equation of an effective Hamiltonian:","category":"page"},{"location":"manual/fDMRG/","page":"Finite DMRG","title":"Finite DMRG","text":"beginaligned\nH_mathrmeff_(s_iα_iβ_i)(s_iα_iβ_i)A^s_i_α_iβ_i = λ A^s_i_α_iβ_i\nendaligned","category":"page"},{"location":"manual/fDMRG/","page":"Finite DMRG","title":"Finite DMRG","text":"The saddle conditions can be satisfied if λ is an eigenvalue of H_mathrmeff and A is the corresponding eigenvector which is normalized as tr(A^A)=1 (we can check that with this normalization the wave function is normalized and the partial derivative to λ of energy functional is 0).","category":"page"},{"location":"manual/fDMRG/","page":"Finite DMRG","title":"Finite DMRG","text":"We can also see that when the wave function is normalized E=A^H_effA = λ, thus the minimal value of λ corresponds to the ground state energy.","category":"page"},{"location":"manual/fDMRG/","page":"Finite DMRG","title":"Finite DMRG","text":"We repeat this process for every site and swipe forth and back until the energy converges. This algorithm is called the single-site DMRG.","category":"page"},{"location":"manual/TransferMatrix/#s_TM","page":"Transfer Matrix","title":"Transfer Matrix","text":"","category":"section"},{"location":"manual/MPS/#s_MPS","page":"Matrix Product State","title":"Matrix Product State","text":"","category":"section"},{"location":"manual/MPS/","page":"Matrix Product State","title":"Matrix Product State","text":"Matrix product state is a special type of tensor network state.","category":"page"},{"location":"manual/MPS/","page":"Matrix Product State","title":"Matrix Product State","text":"The story of a general tensor network starts from a directed graph in space. A directed graph is a lattice structure with discrete lattice sites on some spatial points and each site has some directed lines attached to it. Each directed line has an arrow on it. Some of the lines connect two different sites directly, while each of the other lines attach to only one site and has an open end.","category":"page"},{"location":"manual/MPS/","page":"Matrix Product State","title":"Matrix Product State","text":"(Image: mps_graph)","category":"page"},{"location":"manual/MPS/","page":"Matrix Product State","title":"Matrix Product State","text":"Tensor network is a network structure of tensor maps on a directed graph. We associate a vector space (or in general, an object of a tensor category) to each directed line and a tensor map to each lattice site. The arrow on each line is used to distinguish the   vector space and its dual, i.e., the dual of a vector space V is represented by a leg of vector space V with an arrow pointing in the opposite direction. A tensor map is a linear map from its domain to codomain. We numerate all the lines attached to a site as 1  N_1+N_2, and treat the tensor product of the spaces on lines 1N_1 as the codomain and that on lines N_1+1N_1+N_2 as the domain. A tensor is a tensor map with a trivial domain (N_2=0), or equivalently, a line corresponding to the unit simple object of the tensor category which can be removed or added at will. If a line connects two sites, it represents a contraction between two tensor maps. We also call the lines as legs or bonds.","category":"page"},{"location":"manual/MPS/","page":"Matrix Product State","title":"Matrix Product State","text":"Matrix product state is a tensor network that all the lattice sites are ordered in a one-dimensional chain and each tensor only connects to its left and right nearest neighbors.","category":"page"},{"location":"manual/MPS/","page":"Matrix Product State","title":"Matrix Product State","text":"The basic form of an MPS is","category":"page"},{"location":"manual/MPS/","page":"Matrix Product State","title":"Matrix Product State","text":"(Image: mps_convention)","category":"page"},{"location":"manual/MPS/","page":"Matrix Product State","title":"Matrix Product State","text":"We use the conventions that are consistent with that in TensorLabXD.jl as shown in (b) and (c) of the above figure.","category":"page"},{"location":"manual/MPS/","page":"Matrix Product State","title":"Matrix Product State","text":"The most general form of an MPS is","category":"page"},{"location":"manual/MPS/","page":"Matrix Product State","title":"Matrix Product State","text":"(Image: mps_ABconvention)","category":"page"},{"location":"manual/MPS/","page":"Matrix Product State","title":"Matrix Product State","text":"Since MPSs are usually used to represent the wave functions of quantum many-body systems on a lattice and each lattice site hosts a Hilbert space, the tensor A^i on that lattice site has an open leg which hosts the physical Hilbert space. We call the tensor map A^i as a site tensor and its open leg as the physical leg. A^i also has two legs that    connect to its left and right neighbors. The vector space of these two legs do not have direct physical meaning, thus we call them virtual legs, and the corresponding vector spaces as virtual spaces. The tensor B^i, which does not have a physical leg, is called a bond tensor. The existence of bond tensor is convenient when we construct the MPS in the projected entangled-pairs way. The bond tensors represent the maximally entangled pairs in the virtual space and the site tensors are projections from virtual spaces to the physical space.","category":"page"},{"location":"manual/MPS/#ss_fundamentaltheorem","page":"Matrix Product State","title":"fundamental theorem of MPS","text":"","category":"section"},{"location":"manual/MPS/#ss_canonicalform","page":"Matrix Product State","title":"Canonical form","text":"","category":"section"},{"location":"manual/MPS/","page":"Matrix Product State","title":"Matrix Product State","text":"There are different canonical forms of the MPS: left canonical form, right canonical form, site canonical form, bond canonical form, Gamma-Lambda form... They can be transformed to each other.","category":"page"},{"location":"manual/MPS/","page":"Matrix Product State","title":"Matrix Product State","text":"In Gamma-Lambda form, the bond tensors B^i are renamed as the Lambda tensors Λ^i, which is a diagonal matrix that stores the Schmidt values of that bond. We draw the MPS in Gamma-Lambda as","category":"page"},{"location":"manual/MPS/","page":"Matrix Product State","title":"Matrix Product State","text":"(Image: mps_GammaLambda)","category":"page"},{"location":"manual/MPS/","page":"Matrix Product State","title":"Matrix Product State","text":"If the above MPS is a finite MPS with length L=3, we will have Λ^1=Λ^4=1, since the first and last bonds are trivial with bond dimension 1. If we are thinking about an infinite MPS which is a translational invariant structure with unit cell of length 3, we need to identify Λ^4 with Λ^1 and they are not trivial.","category":"page"},{"location":"manual/MPS/","page":"Matrix Product State","title":"Matrix Product State","text":"Once we obtain the Gamma-Lambda form, the left canonical form can be obtained by defining the local site tensor as AL^i= Λ^iΓ^i, and the right canonical form can be obtained by defining the local site tensor as AR^i=Γ^iΛ^i+1. The site canonical form with central site n can be obtained by defining the the site tensors on i= 1n-1 as AL^i, the site tensors on i = n+1L as AR^i, and the central site tensor as AC^n=Λ^nΓ^nΛ^n+1.","category":"page"},{"location":"manual/MPS/","page":"Matrix Product State","title":"Matrix Product State","text":"We will store the Schmidt values of each bond separately no matter which canonical form we are in. And we label the site tensors by left, right, site, and Gamma. If in left, right and site canonical form, the bond tensors are identities. If in Gamma-Lambda form, the bond tensors are Λ matrices whose diagonal elements are the Schmidt values. If in non-canonical form, the bond tensors can be any matrices. It is useful when we construct the MPS from projected entangled pairs.","category":"page"},{"location":"manual/MPS/","page":"Matrix Product State","title":"Matrix Product State","text":"Now we discuss how to transform a general MPS to canonical forms.","category":"page"},{"location":"manual/MPS/","page":"Matrix Product State","title":"Matrix Product State","text":"For a finite MPS, it can be done by doing SVD or QR decomposition from one end of the MPS.","category":"page"},{"location":"manual/MPS/","page":"Matrix Product State","title":"Matrix Product State","text":"For an infinite MPS, it is in principle can be obtained by diagonalizing the transfer matrix. A better way is explained in [ref].","category":"page"},{"location":"manual/MPS/#Bibliography","page":"Matrix Product State","title":"Bibliography","text":"","category":"section"},{"location":"manual/MPS/","page":"Matrix Product State","title":"Matrix Product State","text":"[Frank1]: Ignacio Cirac, David Perez-Garcia, Norbert Schuch, Frank Verstraete, Matrix Product States and Projected Entangled Pair States: Concepts, Symmetries, and Theorems, arXiv:2011.12127v2","category":"page"},{"location":"index/#Index","page":"Index","title":"Index","text":"","category":"section"},{"location":"index/","page":"Index","title":"Index","text":"","category":"page"},{"location":"manual/Examples/#s_Examples","page":"Examples","title":"Examples","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"CurrentModule = MPSLabXD","category":"page"},{"location":"#MPSLabXD","page":"Home","title":"MPSLabXD","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"MPSLabXD.jl is a generic package which implements tensor network algorithms based on matrix product states (MPS).","category":"page"},{"location":"","page":"Home","title":"Home","text":"It depends on the package TensorLabXD.jl which deals with basic operations of tensor maps. (TensorLabXD.jl is a modified version of Jutho Haegeman's package TensorKit.jl.)","category":"page"},{"location":"#Contents-of-the-manual","page":"Home","title":"Contents of the manual","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Pages = [\"manual/MPS.md\",\"manual/fDMRG.md\",\"manual/MPO.md\"]\nDepth = 3","category":"page"},{"location":"manual/Observables/#s_observables","page":"Observables","title":"Observables","text":"","category":"section"},{"location":"manual/iDMRG/#s_iDMRG","page":"Infinite Dentity Matrix Renormalization Group","title":"Infinite Dentity Matrix Renormalization Group","text":"","category":"section"}]
}
