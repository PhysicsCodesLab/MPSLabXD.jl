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
    ],
)

deploydocs(;
    repo="github.com/PhysicsCodesLab/MPSLabXD.jl",
    devbranch="master",
)
