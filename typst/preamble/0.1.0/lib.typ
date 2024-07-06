#import "@preview/ctheorems:1.1.2": *

// * project setup.
#let project(
  course: "~COURSE~",
  sem: "~Sem~",
  title: "TITLE",
  subtitle: "subtitle",
  authors: ("Shaleen Baral",),
  body,
  contents: true,
  end: none
) = {
  set document(author: authors, title: title)
  set page(
    numbering: "1",
    number-align: center,
    margin: (top: 1in, bottom: 1in, x: 1in),
  )
  set text(font: "KpRoman", size: 10pt)

  show link: underline;

  set enum(indent: 15pt, numbering: "a.")

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
    Authors: #authors.join(", ")
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
    \ #(counter(heading).display() + " " * 3 + it.body) \
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

// * theorem environments.
#let prop = thmbox("proposition", "Proposition", fill: rgb("#e8e8f8"))
#let lemma = thmbox("lemma", "Lemma", fill: rgb("#efe6ff"))
#let corollary = thmbox("corollary", "Corollary", base: "proposition", fill: rgb("#f8e8e8"))
#let definition = thmbox("definition", "Definition", inset: (x: 1.2em, top: 1em))

// examples and remarks are not numbered.
#let example = thmplain("example", "Example").with(numbering: none)
#let remark = thmplain("remark", "Remark", inset: 0em).with(numbering: none)

// proofs are attached to theorems, although they are not numbered.
// qed should always be in a new line
#let proof = thmproof("proof", "Proof", base: "theorem", bodyfmt: body => [
  #body \ #h(1fr) $square$
])

// * math conveniences.
#let to = $arrow.long$
#let iff = $arrow.long.double.l.r$
#let implies = $arrow.double.long$

#let inner(x, y) = $lr(angle.l #x, #y angle.r)$

#let id = "id"
#let OPT = `OPT`
#let ALG = `ALG`

#let Hom = (c, a, b) => $"Hom"_(#c)(#a, #b)$
#let Obj = $"Obj"$

// * aesthetics.
#set enum(indent: 15pt, numbering: "a.")
