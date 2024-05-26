#import "@preview/ctheorems:1.1.2": *

#let project(course:"~COURSE~", sem:"~Sem~", title: "TITLE", subtitle: "subtitle", authors: (), body) = {
  // Set the document's basic properties.
  set document(author: authors, title: title)
  set page(numbering: "1", number-align: center, margin: (
    top: 1in,
    bottom: 1in,
    x: 1in,
  ),)
  set text(font: "KpRoman", size: 10pt)

  show math.equation: set text(font: "New Computer Modern Math")

  // Metadata box.
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
  

  show outline.entry.where(
  level: 1
  ): it => {
    v(12pt, weak: true)
    strong(delta: 150, it)
}
  
  outline(indent: auto)
  pagebreak()

  // Heading.
  set heading(numbering: "1.")
  show heading: it => [
    \ #(counter(heading).display() + " "*3 + it.body) \
  ]
  
  show: thmrules.with(qed-symbol: $square$)

  // Main body.
  set par(justify: true)
  
  body
  
  // show heading: it => it.body
  // pagebreak()
  // bibliography("works.bib") 
}

// * theorem environments. 

#let prop = thmbox(
  "proposition",
  "Proposition",
  fill: rgb("#e8e8f8")
)
#let theorem = prop

#let lemma = thmbox(
  "lemma",
  "Lemma",
  fill: rgb("#efe6ff")
)

#let corollary = thmbox(
  "corollary",
  "Corollary",
  base: "proposition",
  fill: rgb("#f8e8e8")
)

#let definition = thmenv(
  "definition",
  "heading",
  none,
  (name, number, body, color: black) => [
    #text(color)[#h(0.5em)*Definition #number #name.*]
    #h(0.2em)
    #body
    #v(0.2em)
  ]
)

// Examples and remarks are not numbered
#let example = thmplain("example", "Example").with(numbering: none)
#let remark = thmplain(
  "remark",
  "Remark",
  inset: 0em
).with(numbering: none)

// Proofs are attached to theorems, although they are not numbered
#let proof = thmproof(
  "proof",
  "Proof",
  base: "theorem",
  bodyfmt: body => [
    #body \ #h(1fr) $square$
  ]
)

// * math conveniences. 

#let to = $arrow.long$
#let iff = $arrow.long.double.l.r$
#let id = "id"
#let implies = $arrow.double.long$

