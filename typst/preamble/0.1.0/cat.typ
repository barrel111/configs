/// Hom-set $"Hom"_(\sans(C))(a, b)$.
///
/// - c (str): Category name, rendered in sans-serif.
/// - a (content): Source object.
/// - b (content): Target object.
#let Hom = (c, a, b) => $"Hom"_(sans(#c))(#a, #b)$

/// Object class $"Obj"(\sans(C))$.
///
/// - c (str): Category name, rendered in sans-serif.
#let Obj = c => $"Obj"(sans(#c))$
