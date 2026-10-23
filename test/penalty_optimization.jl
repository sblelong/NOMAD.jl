@testset "Example: MADS-PIP" begin
    function bb(x)
        f = x[1]^2 + x[2]^2
        c = x[1] + x[2] - 1.0
        return (true, true, [f ; c])
    end

    p = NomadProblem(2, 2, ["OBJ"; "EQPB"], bb, lower_bound=[-5.0; -5.0], upper_bound=[5.0; 5.0], granularity = [0.0;0.0])
    p.options.max_bb_eval = 1000
    p.options.madspip_optimization = true

    result = solve(p, [2.0; 2.0])

    @test result.feasible == true
    @test result.x_sol !== nothing
    @test result.bbo_sol !== nothing
end