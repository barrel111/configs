#import "@preview/ctheorems:1.1.3": *


#let colors = (
  prop: (bg: rgb("#7567B8").lighten(88%), border: rgb("#483D88")),
  lemma: (bg: rgb("#7F95D1").lighten(85%), border: rgb("#7F95D1")),     // Vista Blue
  corollary: (bg: rgb("#567F91").lighten(90%), border: rgb("#567F91")),
  definition: (bg: rgb("#FFEBE7").lighten(60%), border: rgb("#CC5A71")), // Misty Rose with Blush border
)

// * project setup.
#let project(
  course: "~COURSE~",
  sem: "~Sem~",
  title: "TITLE",
  subtitle: "subtitle",
  authors: ("Shaleen Baral",),
  authors-label: "Authors:",
  body,
  contents: true,
  end: none,
) = {
  set document(author: authors, title: title)
  set page(
    numbering: "1",
    number-align: center,
    margin: (top: 0.8in, bottom: 0.8in, x: 0.85in),
  )
  set text(font: "EB Garamond", 11pt)

  show link: underline

  set enum(indent: 15pt, numbering: "a.")
  set list(indent: 15pt)

  // metadata box.
  rect(width: 100%, stroke: (top: 1pt, bottom: 1pt, rest: 0pt))[
    *#course* #h(1fr) *#sem*
    #align(center)[
      #block(text(weight: 100, 1.75em, title))
    ]
    #align(center)[
      #block(text(weight: 400, 1.15em, subtitle))
    ]
    #authors-label #authors.join(", ")
  ]

  // table of contents.
  if contents {
    show outline.entry.where(level: 1): it => {
      v(12pt, weak: true)
      strong(delta: 200, it)
    }

    set outline.entry(fill: none)
    outline(indent: auto)
    pagebreak()
  }

  // heading.
  set heading(numbering: "1.")
  show heading: it => {
    let size = (1.2em, 1.05em, 1em).at(calc.min(it.level - 1, 2))
    block(text(size: size, weight: "bold",
      counter(heading).display() + h(0.5em) + it.body))
  }

  // qed should be square with black outline and
  // no fill.
  show: thmrules.with(qed-symbol: $square$)

  // main body.
  set par(justify: true)

  body

  // end content (optional).
  // usually for something like a bibliography
  if end != none {
    show heading: it => it.body
    pagebreak()
    end
  }
}

// * quality of life
#let numbered_eq(body) = math.equation(block: true, numbering: "(1)", body)

// examples and remarks are not numbered.
#let example = thmplain("example", "Example", inset: 0em).with(numbering: none)
#let remark = thmplain("remark", "Remark", inset: 0em).with(numbering: none)

// * theorem environments.
#let _thmbox-defaults = (radius: 0em, inset: (x: 0.5em, y: 0.65em))

#let prop       = thmbox("proposition", "Proposition", .._thmbox-defaults, fill: colors.prop.bg, stroke: (left: colors.prop.border + 2.5pt))
#let lemma      = thmbox("lemma", "Lemma", .._thmbox-defaults, fill: colors.lemma.bg, stroke: (left: colors.lemma.border + 2.5pt))
#let corollary  = thmbox("corollary", "Corollary", base: "proposition", .._thmbox-defaults, fill: colors.corollary.bg, stroke: (left: colors.corollary.border + 2.5pt))
#let definition = thmbox("definition", "Definition", .._thmbox-defaults, fill: colors.definition.bg, stroke: (left: colors.definition.border + 2.5pt), padding: (top: 0em, bottom: 0em))

// proofs are attached to propositions, although they are not numbered.
#let proof = thmproof("proof", "Proof", base: "proposition", inset: (x: 0.5em, y: 0em), bodyfmt: body => [#body \ #h(1fr) $square$])

// * math conveniences.
#let to = $->$
#let iff = $arrow.long.double.l.r$
#let implies = $arrow.double.long$

#let inner(x, y) = $lr(angle.l #x, #y angle.r)$
#let conv(it) = $"conv"({#it})$
#let cone(it) = $"cone"({#it})$

#let id  = $"id"$
#let OPT = $"OPT"$
#let ALG = $"ALG"$

#let Hom = (c, a, b) => $"Hom"_(sans(#c))(#a, #b)$
#let Obj = (c) => $"Obj"(sans(#c))$

// * problem set.
#let pset-setup(body) = {
  set enum(indent: 15pt, numbering: "a.")
  set list(indent: 15pt)
  show: thmrules.with(qed-symbol: $square$)
  body
}

#let p = counter("problem")
#let problem(it) = block[
  #p.step()
  #text(size: 12pt)[*Problem #context p.display().* (#it)] 
]

#let math-fw(body) = block[\ #box(width: 100%)[#body]]

#let highlight(body, color: rgb("#FEF2A0")) = {
  box(
    fill: color,
    inset: (x: 0.1em, y: 0em),
    outset: (y: 0.15em),
    radius: 0.12em,
    body
  )
}
