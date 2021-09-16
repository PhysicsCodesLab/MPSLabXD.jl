using MPSXD
using Documenter

DocMeta.setdocmeta!(MPSXD, :DocTestSetup, :(using MPSXD); recursive=true)

makedocs(;
    modules=[MPSXD],
    authors="PhysicsCodesLab",
    repo="https://github.com/PhysicsCodesLab/MPSXD.jl/blob/{commit}{path}#{line}",
    sitename="MPSXD.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://PhysicsCodesLab.github.io/MPSXD.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/PhysicsCodesLab/MPSXD.jl",
    devbranch="master",
)
