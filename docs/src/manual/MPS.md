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
one-dimensional chain and each tensor only connects to its left and right nearest number.

![mps_convention](figures/mps_convention.svg)

## [Local tensor](@id ss_localtensor)
