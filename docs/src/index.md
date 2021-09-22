```@meta
CurrentModule = MPSLabXD
```

# MPSLabXD

[MPSLabXD.jl](https://github.com/PhysicsCodesLab/MPSLabXD.jl) is a generic package which
implements tensor network methods based on matrix product states (MPS) to calculate the
properties of quantum many-body systems.

It depends on the package [TensorLabXD.jl](https://github.com/PhysicsCodesLab/TensorLabXD.jl)
which deals with basic operations of tensor maps. (TensorLabXD.jl is a modified version of
Jutho Haegeman's package [TensorKit.jl](https://github.com/Jutho/TensorKit.jl).)




## Contents of the manual

```@contents
Pages = ["manual/Introduction.md", "manual/MPS.md", "manual/MPO.md",
"manual/TransferMatrix.md", "manual/fDMRG.md", "manual/iDMRG.md",
"manual/Observables.md", "manual/Examples.md"]
Depth = 3
```

```@autodocs
Modules = [MPSLabXD]
```
