println("------------------------------------")
println("mps_test.jl")
println("------------------------------------")

time_initial = time()
@timedtestset "local tensors" begin
    @test 1+1 == 2
end

time_final = time()
printstyled("Finished sector tests in ",
            string(round(time_final-time_initial; sigdigits=3)),
            " seconds."; bold = true, color = Base.info_color())
println()
