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
        "Manual" => ["manual/MPS.md"],
        "Index" => ["index/index.md"]
    ],
)

deploydocs(;
    repo="github.com/PhysicsCodesLab/MPSLabXD.jl.git",
    devbranch="master",
)
