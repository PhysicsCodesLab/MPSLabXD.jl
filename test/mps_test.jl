println("------------------------------------")
println("mps_test.jl")
println("------------------------------------")

time_initial = time()

using Revise
using TensorLabXD
using MPSLabXD
V_virtual = SU₂Space(0=>5,1/2=>5,1=>5);
V_physical = SU₂Space(1/2=>1);
V_boundary = SU₂Space(0=>1);
A1 = TensorMap(randn, V_boundary*V_physical, V_virtual);
A2 = TensorMap(randn,V_virtual*V_physical,V_virtual);
A3 = TensorMap(randn,V_virtual*V_physical,V_boundary);
L = 6;
s = [ntuple(i -> [1.0], L)...];

@timedtestset "finite mps" begin
    mps = FiniteMPS{SU₂Space}([A1,A2,A2,A2,A2,A3],s,[:non_canonical]);
    @test length(mps) == L
end

@timedtestset "infinite mps" begin

end
time_final = time()
printstyled("Finished sector tests in ",
            string(round(time_final-time_initial; sigdigits=3)),
            " seconds."; bold = true, color = Base.info_color())
println()
