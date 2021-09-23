using MPSLabXD
using Documenter

makedocs(;
    modules=[MPSLabXD],
    authors="PhysicsCodesLab",
    sitename="MPSLabXD.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", nothing) == "true",
        mathengine = MathJax()
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
    repo="github.com/PhysicsCodesLab/MPSLabXD.jl.git",
    devbranch="master",
)
