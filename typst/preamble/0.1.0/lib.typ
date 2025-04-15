#import "@preview/ctheorems:1.1.3": *

#let thmfill = (prop: rgb("#e8e8f8"), lemma: rgb("#efe6ff"), corollary: rgb("#f8e8e8"))
// #let thmfill = (prop: none, lemma: none, corollary: none)

// * project setup.
#let project(
  course: "~COURSE~",
  sem: "~Sem~",
  title: "TITLE",
  subtitle: "subtitle",
  authors: ("Shaleen Baral",),
  authors_label: "Authors:",
  body,
  contents: true,
  end: none,
) = {
  set document(author: authors, title: title)
  set page(
    numbering: "1",
    number-align: center,
    margin: (top: 1in, bottom: 1in, x: 1in),
  )
  set text(size: 10pt)
  // set text(font: "EB Garamond")

  show link: underline;

  set enum(indent: 15pt, numbering: "a.")
  set list(indent: 15pt)

  show math.equation: set text(font: "New Computer Modern Math")

  // metadata box.
  rect(width: 100%)[
    *#course* #h(1fr) *#sem*
    #align(center)[
      #block(text(weight: 100, 1.75em, title))
    ]
    #align(center)[
      #block(text(weight: 400, 1.15em, subtitle))
    ]
    #authors_label #authors.join(", ")
  ]

  // table of contents.
  if contents {
    show outline.entry.where(level: 1): it => {
      v(12pt, weak: true)
      strong(delta: 200, it)
    }

    outline(indent: auto)
    pagebreak()
  }

  // heading.
  set heading(numbering: "1.")
  show heading: it => [
    #(counter(heading).display() + " " * 3 + it.body)
  ]

  // qed should be square with black outline and
  // no fill.
  show: thmrules.with(qed-symbol: $square$)

  // main body.
  set par(justify: true)

  body

  // end content (optional).
  // usually for something like a bibliography
  if type(end) == content {
    show heading: it => it.body
    pagebreak()
    end
  }
}

// * quality of life
#let numbered_eq(content) = math.equation(block: true, numbering: "(1)", content)

// examples and remarks are not numbered.
#let example = thmplain("example", "Example", inset: 0em).with(numbering: none)
#let remark = thmplain("remark", "Remark", inset: 0em).with(numbering: none)

// * theorem environments.
#let prop = thmbox("proposition", "Proposition", fill: thmfill.prop, radius: 0em, inset: (x: 0.75em, y: 0.75em), stroke: (bottom: 0.25pt, top: 0.65pt))
#let lemma = thmbox("lemma", "Lemma", fill: thmfill.lemma, radius: 0em, inset: (x: 0.65em, y: 0.65em), stroke: (bottom: 0.25pt, top: 0.65pt))
#let corollary = thmbox("corollary", "Corollary", base: "proposition", fill: thmfill.corollary, radius: 0em, inset: (x: 0.65em, y: 0.65em), stroke: (bottom: 0.25pt, top: 0.65pt))
#let definition = thmbox("definition", "Definition", inset: (x: 1em))

// proofs are attached to theorems, although they are not numbered.
// qed should always be in a new line
#let proof = thmproof("proof", "Proof", base: "theorem", bodyfmt: body => [
  #body #h(1fr) $square$
])

// * math conveniences.
#let to = $arrow.long$
#let iff = $arrow.long.double.l.r$
#let implies = $arrow.double.long$

#let inner(x, y) = $lr(angle.l #x, #y angle.r)$
#let conv(it) = $"conv"({#it})$
#let cone(it) = $"cone"({#it})$

#let id = "id"
#let OPT = `OPT`
#let ALG = `ALG`

#let Hom = (c, a, b) => $"Hom"_(sans(#c))(#a, #b)$
#let Obj = $"Obj"$

// * aesthetics.
#set enum(indent: 15pt, numbering: "a.")

// * problem set.
#let p = counter("problem")
#let problem(it) = block[
  #p.step()
  #text(size: 12pt)[*Problem #context p.display().* (#it)] 
]

#let mm(it) = block[\ #box(width: 100%)[#it]]

