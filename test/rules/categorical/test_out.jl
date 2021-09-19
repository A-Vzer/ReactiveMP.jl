module RulesCategoricalOutTest

using Test
using ReactiveMP
using Random
using Distributions
import ReactiveMP: @test_rules

@testset "rules:Categorical:out" begin

     @testset "Belief Propagation: (m_p::PointMass)" begin

        @test_rules [ with_float_conversions = false ] Categorical(:out, Marginalisation) [
            (input = (m_p = PointMass(1.0), ), output = Categorical(1.0)),
        ]

    end
end
end