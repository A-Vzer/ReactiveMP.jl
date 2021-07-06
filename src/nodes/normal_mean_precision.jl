import StatsFuns: log2π

@node NormalMeanPrecision Stochastic [ out, (μ, aliases = [ mean ]), (τ, aliases = [ invcov, precision ]) ]

conjugate_type(::Type{ <: NormalMeanPrecision }, ::Type{ Val{ :out } }) = NormalMeanPrecision
conjugate_type(::Type{ <: NormalMeanPrecision }, ::Type{ Val{ :μ } })   = NormalMeanPrecision
conjugate_type(::Type{ <: NormalMeanPrecision }, ::Type{ Val{ :τ } })   = Gamma

@average_energy NormalMeanPrecision (q_out::Any, q_μ::Any, q_τ::Any) = begin
    μ_mean, μ_var     = mean(q_μ), var(q_μ)
    out_mean, out_var = mean(q_out), var(q_out)
    return 0.5 * (log2π - logmean(q_τ) + mean(q_τ) * (μ_var + out_var + abs2(μ_mean - out_mean)))
end

@average_energy NormalMeanPrecision (q_out_μ::Any, q_τ::Any) = begin
    out_μ_mean, out_μ_var     = mean(q_out_μ), cov(q_out_μ)
  
    return 0.5 * (log2π - logmean(q_τ) + mean(q_τ) * (out_μ_var[1,1]+out_μ_var[2,2] - out_μ_var[1,2] - out_μ_var[2,1] + abs2(out_μ_mean[2] - out_μ_mean[1])))
end