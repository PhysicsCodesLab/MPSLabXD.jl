# [Matrix Product State](@id s_MPS)

Matrix product state is a special type of tensor network state.

The story of a general tensor network starts from a directed graph in space. A directed
graph is a lattice structure with discrete lattice sites on some spatial points and each
site has some directed edges attached to it. Each directed edge has an arrow on it. Some of
the edges connect two different sites, while the other edges attach to only one site and
have an open end.

Tensor network is a network structure of tensor maps on a directed graph. We associate a
vector space (or in general, an object of a tensor category) to each of the directed edges
and a tensor map to each lattice site. The arrow on edges are used to distinguish the vector
space and its dual, i.e., the dual of a vector space ``V`` is represented by an edge of
vector space ``V`` with an arrow pointing in the opposite direction. A tensor map is a
linear map from its domain to codomain. We numerate all the edges attached to a site as
``1, ..., N_1+N_2``, and treat the tensor product of the edges ``1,...,N_1`` as the codomain
of the tensor map and treat the tensor product of the edges ``N_1+1,...,N_1+N_2`` as the
domain of the tensor map. A tensor is a tensor map which a trivial domain with zero edges or
an edge corresponds to unit simple object of the tensor category. If an edge connects
two sites, it represents a contraction between two tensor maps. We also call the edges as
legs.

Matrix product state is a tensor network that all the lattice site are ordered as a
one-dimensional chain and each tensor only connects to its left and right nearest
neighbour.

The basic structure of an MPS is

![mps_convention](figures/mps_convention.svg)

We use the conventions that are consistent with that in TensorLabXD.jl.

There are different canonical forms of the MPS: left canonical form, right canonical form,
site canonical form, bond canonical form,                  Gamma-Lambda form...

To be able to represent all these different forms under the same structure, we write the
MPS as

![mps_convention](figures/mps_ABconvention.svg)

Since MPSs are usually used to represent the wave functions of quantum many-body systems on
a lattice and each lattice site hosts a Hilbert space, the tensor ``A^{[i]}`` on that site
has an open leg which hosts the physical Hilbert space. We call the tensor ``A^{[i]}`` as
a site tensor, and its open leg as the physical leg. ``A^{[i]}`` also has two legs that
connect to its left and right neighbour. The vector space of these two legs do not have
direct physical meaning, thus we call them virtual legs or bonds, and the corresponding
vector spaces as virtual spaces. The tensor ``B^{[i]}`` which does not have a physical leg
are called a bond tensor. The bond tensors are in principle not necessary, since we can
always absorb it into ``A^{[i]}`` and returns to the original form of MPS with only site
tensors. However, we will find later that keeping the bond tensors will make some of the
algorithms easier.

An MPS can have different boundary conditions


## [Local tensor](@id ss_localtensor)
