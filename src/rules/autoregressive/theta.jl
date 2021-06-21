export rule

@rule AR(:θ, Marginalisation) (q_y_x::MultivariateNormalDistributionsFamily, q_γ::GammaShapeRate, meta::ARMeta) = begin
    order = getorder(meta)
    F     = getvform(meta)

    myx, Vyx = mean_cov(q_y_x)
    my, Vy   = ar_slice(F, myx, 1:order), ar_slice(F, Vyx, 1:order, 1:order)
    mx, Vx   = ar_slice(F, myx, order+1:2order), ar_slice(F, Vyx, order+1:2order, order+1:2order)
    Vyx      = ar_slice(F, Vyx, order+1:2order, 1:order)

    mγ = mean(q_γ)

    D = mγ * (Vx + mx * mx')
    T = promote_type(eltype(q_y_x), eltype(q_γ))
    c = ar_unit(T, getvform(meta), order)

    mθ, Vθ = cholinv(D) * (Vyx + mx * my') * mγ * c, cholinv(D)
    
    return convert(promote_variate_type(F, NormalMeanVariance), mθ, Vθ)
end
