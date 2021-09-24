using MPSLabXD
using Test
using TestExtras
using TensorLabXD

const TX = TensorLabXD

time_initial = time()
include("mps_test.jl")
time_final = time()
printstyled("Finished all tests in ",
            string(round((time_final-time_initial)/60; sigdigits=3)),
            " minutes."; bold = true, color = Base.info_color())
println()
