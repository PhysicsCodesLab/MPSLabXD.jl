# [Matrix Product State](@id s_MPS)

Matrix product state is a special type of tensor network state.

The story of a general tensor network starts from a directed graph in space. A directed
graph is a lattice structure with discrete lattice sites on some points in space and each
site has some directed edges attached to it. Each directed edge has an arrow on it. Some of
the edges connect two different sites, while some of the edges attach to only one site and
have an open end.

Tensor network is a network structure of tensor maps on a directed graph. We associate a
vector space (or in general, an object of a tensor category) to each of the directed edges
and a tensor map to each lattice site. A tensor map is a linear map from its domain to
codomain. We numerate all the edges attached to a site as ``1, ..., N_1+N_2``, and treat
the tensor product of the edges ``1,...,N_1`` as the codomain of the tensor map, and treat
the tensor product of the edges ``N_1+1,...,N_1+N_2`` as the domain of the tensor map. To
distinguish the vector space and dual, we give a 



We call these edges as The
edges that point from one site to another site is a contraction be




## [Local tensor](@id ss_localtensor)
