/// Indicator function $bb(1)[S]$.
///
/// - s (content): Event or set.
#let ind(s) = $bb(1)[#s]$

/// Probability $bb(P){E}$.
///
/// - e (content): Event.
#let Pr(e) = $bb(P) lr({#e})$

/// Conditional probability $bb(P)[E | F]$.
///
/// - e (content): Event.
/// - f (content): Conditioning event.
#let Prcond(e, f) = $bb(P)[#e | #f]$

/// Expectation $bb(E)[X]$.
///
/// - x (content): Random variable.
#let EE(x) = $bb(E)[#x]$

/// Conditional expectation $bb(E)[X | Y]$.
///
/// - x (content): Random variable.
/// - y (content): Conditioning variable or event.
#let EEcond(x, y) = $bb(E)[#x | #y]$

/// Variance $"Var"[X]$.
///
/// - x (content): Random variable.
#let Var(x) = $"Var"[#x]$

/// Covariance $"Cov"(X, Y)$.
///
/// - x (content): First random variable.
/// - y (content): Second random variable.
#let Cov(x, y) = $"Cov"(#x, #y)$
