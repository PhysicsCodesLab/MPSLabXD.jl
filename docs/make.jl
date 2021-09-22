using MPSLabXD
using Documenter

DocMeta.setdocmeta!(MPSLabXD, :DocTestSetup, :(using MPSLabXD); recursive=true)

makedocs(;
    modules=[MPSLabXD],
    authors="PhysicsCodesLab",
    repo="https://github.com/PhysicsCodesLab/MPSLabXD.jl/blob/{commit}{path}#{line}",
    sitename="MPSLabXD.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://PhysicsCodesLab.github.io/MPSLabXD.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Manual" => ["manual/Introduction.md", "manual/MPS.md", "manual/MPO.md",
        "manual/TransferMatrix.md", "manual/fDMRG.md", "manual/iDMRG.md",
        "manual/Observables.md", "manual/Examples.md"],
        "Index" => ["index/index.md"]
    ],
)

deploydocs(;
    repo="github.com/PhysicsCodesLab/MPSLabXD.jl",
    devbranch="master",
)
