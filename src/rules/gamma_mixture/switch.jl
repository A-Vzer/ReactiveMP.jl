import SpecialFunctions: logabsgamma
@rule GammaMixture{N}(:switch, Marginalisation) (q_out::Any, q_a::NTuple{N, GammaDistributionsFamily }, q_b::NTuple{N, GammaDistributionsFamily }) where { N } = begin

    U = map(zip(q_a, q_b)) do (a, b)
        return -score(AverageEnergy(), GammaShapeRate, Val{ (:out, :α, :β) }, map(as_marginal, (q_out, a, b)), nothing)
    end

    ρ = softmax(U)
    return Categorical(ρ)
end
