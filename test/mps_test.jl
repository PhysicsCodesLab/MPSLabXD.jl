println("------------------------------------")
println("mps_test.jl")
println("------------------------------------")

time_initial = time()

using Revise
using TensorLabXD
using MPSLabXD
using KrylovKit
V_virtual = SU₂Space(0=>5,1/2=>5,1=>5);
V_physical = SU₂Space(1/2=>1);
V_boundary = SU₂Space(0=>1);
A1 = TensorMap(randn, V_boundary*V_physical, V_virtual);
A2 = TensorMap(randn,V_virtual*V_physical,V_virtual);
A3 = TensorMap(randn,V_virtual*V_physical,V_boundary);
L = 6;
s = [[1.0] for i in 1:L];

@timedtestset "finite mps" begin
    mps1 = FiniteMPS{SU₂Space}([A1,A2,A2,A2,A2,A3],s,[:non_canonical]);
    @test field(mps1) == ℂ
    @test spacetype(mps1) == SU₂Space == Rep[SU₂]
    @test sectortype(mps1) == SU2Irrep == Irrep[SU₂]
    make_left_canonical(mps1);
    for i in 1:L
        @test mps1.Ts[i]'*mps1.Ts[i] ≈ isomorphism(domain(mps1.Ts[i]),domain(mps1.Ts[i]))
    end
    @test norm(mps1) ≈ 1.0
    mps2 = FiniteMPS{SU₂Space}([A1,A2,A2,A2,A2,A2,A2,A3],s,[:non_canonical]);
    make_right_canonical(mps2);
    for i in 1:L
        T_tmp = TensorMap(undef,codomain(mps2.Ts[i],1),codomain(mps2.Ts[i],1))
        @tensor T_tmp[a;d] = mps2.Ts[i][a,b;c]*conj(mps2.Ts[i][d,b;c])
        @test T_tmp ≈ isomorphism(codomain(mps2.Ts[i],1),codomain(mps2.Ts[i],1))
    end
    @test norm(mps2) ≈ 1.0
end

@timedtestset "infinite mps" begin

end
time_final = time()
printstyled("Finished sector tests in ",
            string(round(time_final-time_initial; sigdigits=3)),
            " seconds."; bold = true, color = Base.info_color())
println()
