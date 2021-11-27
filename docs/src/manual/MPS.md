# [Matrix Product State](@id s_MPS)

Matrix product state is a special type of tensor network state.

The story of a general tensor network starts from a directed graph in space. A directed
graph is a lattice structure with discrete lattice sites on some spatial points and each
site has some directed lines attached to it. Each directed line has an arrow on it. Some of
the lines connect two different sites directly, while each of the other lines attach to
only one site and has an open end.

![mps_graph](figures/mps_graph.svg)

Tensor network is a network structure of tensor maps on a directed graph. We associate a
vector space (or in general, an object of a tensor category) to each directed line
and a tensor map to each lattice site. The arrow on each line is used to distinguish the  
vector space and its dual, i.e., the dual of a vector space ``V`` is represented by a leg of
vector space ``V`` with an arrow pointing in the opposite direction. A tensor map is a
linear map from its domain to codomain. We numerate all the lines attached to a site as
``1, ..., N_1+N_2``, and treat the tensor product of the spaces on lines ``1,...,N_1`` as
the codomain and that on lines ``N_1+1,...,N_1+N_2`` as
the domain. A tensor is a tensor map with a trivial domain (``N_2=0``), or equivalently, a
line corresponding to the unit simple object of the tensor category which can be removed
or added at will. If a line connects two sites, it represents a contraction between two
tensor maps. We also call the lines as legs or bonds.

Matrix product state is a tensor network that all the lattice sites are ordered in a
one-dimensional chain and each tensor only connects to its left and right nearest
neighbors.

The **basic** form of an MPS is

![mps_convention](figures/mps_convention.svg)

We use the conventions that are consistent with that in TensorLabXD.jl as shown in (b) and
(c) of the above figure.

The **most general form** of an MPS is

![mps_ABconvention](figures/mps_ABconvention.svg)

Since MPSs are usually used to represent the wave functions of quantum many-body systems on
a lattice and each lattice site hosts a Hilbert space, the tensor ``A^{[i]}`` on that
lattice site
has an open leg which hosts the physical Hilbert space. We call the tensor map ``A^{[i]}``
as a site tensor and its open leg as the physical leg. ``A^{[i]}`` also has two legs that   
connect to its left and right neighbors. The vector space of these two legs do not have
direct physical meaning, thus we call them virtual legs, and the corresponding
vector spaces as virtual spaces. The tensor ``B^{[i]]``, which does not have a physical leg,
is called a bond tensor. The existence of bond tensor is convenient when we construct the
MPS in the projected entangled-pairs way. The bond tensors represent the maximally entangled
pairs in the virtual space and the site tensors are projections from virtual spaces to
the physical space.

## [fundamental theorem of MPS](@id ss_fundamentaltheorem)


## [Canonical form](@id ss_canonicalform)

There are different canonical forms of the MPS: left canonical form, right canonical form,
site canonical form, bond canonical form, Gamma-Lambda form... They can be transformed to
each other.


In Gamma-Lambda form, the bond tensors ``B^{[i]}`` are renamed as the Lambda tensors
``Λ^{[i]}``, which is a diagonal matrix that stores the Schmidt values of that bond.
We draw the MPS in Gamma-Lambda as

![mps_GammaLambda](figures/mps_GammaLambda.svg)

If the above MPS is a finite MPS with length ``L=3``, we will have ``Λ^{[1]}=Λ^{[4]}=1``,
since the first and last bonds are trivial with bond dimension ``1``. If we are thinking
about an infinite MPS which is a translational invariant structure with unit cell of length
``3``, we need to identify ``Λ^{[4]}`` with ``Λ^{[1]}`` and they are not trivial.

Once we obtain the Gamma-Lambda form, the left canonical form can be obtained by defining
the local site tensor as ``AL^{[i]}= Λ^{[i]}Γ^{[i]}``, and the right canonical form can be
obtained by defining the local site tensor as ``AR^{[i]}=Γ^{[i]}Λ^{[i+1]}``. The site
canonical form with central site ``n`` can be obtained by defining the the site tensors on
``i= 1,...,n-1`` as ``AL^{[i]}``, the site tensors on ``i = n+1,...,L`` as ``AR^{[i]}``, and
the central site tensor as ``AC^{[n]}=Λ^{[n]}Γ^{[n]}Λ^{[n+1]}``.

We will store the Schmidt values of each bond separately no matter which canonical form we
are in. And we label the site tensors by left, right, site, and Gamma. If in left, right and
site canonical form, the bond tensors are identities. If in Gamma-Lambda form, the
bond tensors are Λ matrices whose diagonal elements are the Schmidt values. If in
non-canonical form, the bond tensors can be any matrices. It is useful when we construct the
MPS from projected entangled pairs.

Now we discuss how to transform a general MPS to canonical forms.

For a finite MPS, it can be done by doing SVD or QR decomposition from one end of the MPS.

For an infinite MPS, it is in principle can be obtained by diagonalizing the transfer
matrix. A better way is explained in [ref].
