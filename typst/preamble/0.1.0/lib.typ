#import "@preview/ctheorems:1.1.3": *


#let colors = (
  prop: (bg: rgb("#483D8B").lighten(90%), border: rgb("#4B4B80")), // Space Cadet
  lemma: (bg: rgb("#7F95D1").lighten(85%), border: rgb("#7F95D1")),     // Vista Blue
  corollary: (bg: rgb("#80475E").lighten(90%), border: rgb("#80475E")),  // Quinacridone Magenta
  definition: (bg: rgb("#FFEBE7").lighten(60%), border: rgb("#CC5A71")), // Misty Rose with Blush border
  remark: (bg: rgb("#FFEBE7"), border: rgb("#34344A").lighten(50%))      // Misty Rose with lightened Space Cadet
)

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
    margin: (top: 0.8in, bottom: 0.8in, x: 0.85in),
  )
  set text(size: 10pt)
  // set text(font: "Asana Math")
  set text(font: "EB Garamond", 11pt)

  show link: underline;

  set enum(indent: 15pt, numbering: "a.")
  set list(indent: 15pt)

 // #show math.equation: set text(font: "EB Garamond", 10pt) 
 // #show math.equation: set text(font: "New Computer Modern Math")

  // metadata box.
  rect(width: 100%, stroke: (top: 1pt, bottom: 1pt, rest: 0pt))[
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

    set outline.entry(fill: none)
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
#let prop = thmbox("proposition", "Proposition", fill: colors.prop.bg, radius: 0em, inset: (x: 0.5em, y: 0.65em), stroke: (left: colors.prop.border + 2.5pt))//, stroke: (bottom: 0.25pt, top: 0.65pt))
#let lemma = thmbox("lemma", "Lemma", fill: colors.lemma.bg, radius: 0em, inset: (x: 0.5em, y: 0.65em), stroke:(left: colors.lemma.border +  2.5pt)) //, stroke: (bottom: 0.25pt, top: 0.65pt))
#let corollary = thmbox("corollary", "Corollary", base: "proposition", fill: colors.corollary.bg, radius: 0em, inset: (x: 0.5em, y: 0.65em), stroke:(left: colors.corollary.border + 2.5pt))// , stroke: (bottom: 0.25pt, top: 0.65pt))
#let definition = thmbox("definition", "Definition", fill: colors.definition.bg, radius: 0em, stroke:(left: colors.definition.border + 2.5pt), inset: (x: 0.5em, y: 0.65em), padding: (top: 0em, bottom: 0em))

// proofs are attached to theorems, although they are not numbered.
// qed should always be in a new line
#let proof = thmproof("proof", "Proof", base: "theorem", inset: (x: 0.5em, y: 0em), bodyfmt: body => [
  #body #h(1fr) $square$
])

// * math conveniences.
#let to = $->$
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

#let highlight(content, color: rgb("#FEF2A0").lighten(0%)) = {
  box(
    fill: color,
    inset: (x: 0.1em, y: 0em),
    outset: (y: 0.15em),
    radius: 0.12em,
    content
  )
}
