#import "@preview/ctheorems:1.1.3": *


#let colors = (
  prop: (bg: rgb("#7567B8").lighten(88%), border: rgb("#483D88")),
  lemma: (bg: rgb("#7F95D1").lighten(85%), border: rgb("#7F95D1")),
  corollary: (bg: rgb("#567F91").lighten(90%), border: rgb("#567F91")),
  definition: (bg: rgb("#FFEBE7").lighten(60%), border: rgb("#CC5A71")),
  solution: (bg: rgb("#3B6FE0").lighten(85%), border: rgb("#3B6FE0").darken(15%), text: rgb("#3B6FE0").darken(25%)),
)

/// Full document template with metadata header, table of contents, and styled headings.
///
/// - course (str): Course name shown in the top-left of the header.
/// - sem (str): Semester shown in the top-right of the header.
/// - title (str): Document title, displayed centered in the header.
/// - subtitle (str): Subtitle displayed below the title.
/// - authors (array): List of author names.
/// - authors-label (str): Label preceding the author list (default: `"Authors:"`).
/// - contents (bool): Whether to include a table of contents (default: `true`).
/// - end (content): Optional content appended after a page break with unstyled headings — intended for bibliographies.
/// - body (content): The document body.
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
  show math.tilde: math.class.with("normal")

  set enum(indent: 15pt, numbering: "a.")
  set list(indent: 15pt)

  // * metadata box.
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

  // * table of contents.
  if contents {
    show outline.entry.where(level: 1): it => {
      v(12pt, weak: true)
      strong(delta: 200, it)
    }

    set outline.entry(fill: none)
    outline(indent: auto)
    pagebreak()
  }

  // * heading.
  set heading(numbering: "1.")
  show heading: it => {
    let size = (1.2em, 1.05em, 1em).at(calc.min(it.level - 1, 2))
    let num = if it.level == 1 {
      context numbering("I.", counter(heading).get().first())
    } else {
      context {
        let nums = counter(heading).get().slice(1)
        numbering("1." * nums.len(), ..nums)
      }
    }
    block(text(size: size, weight: "bold", num + h(0.5em) + it.body))
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

/// Minimal show rule for problem sets: applies list indentation and theorem QED rules
/// without the full `project` scaffolding (no header, TOC, or heading styles).
/// Use this as `#show: pset-setup` at the top of a document.
#let pset-setup(body) = {
  set enum(indent: 15pt, numbering: "a.")
  set list(indent: 15pt)
  show: thmrules.with(qed-symbol: $square$)
  body
}

// * quality of life

/// A numbered display equation. Equivalent to `$ ... $` with `(1)`-style numbering.
#let numbered_eq(body) = math.equation(block: true, numbering: "(1)", body)

// examples and remarks are not numbered.
#let example = thmplain("example", "Example", inset: 0em, separator: [.#h(0.2em)]).with(numbering: none)
#let remark = thmplain("remark", "Remark", inset: 0em, separator: [.#h(0.2em)]).with(numbering: none)

// * numbering start afresh at base:base-level with no prefix
#let _last-level-dis(..args) = numbering("1", args.pos().last())

// * reference is prefixed by the first and last level of the base
#let _last-level-ref(..args) = {
  let a = args.pos()
  if a.len() >= 3 {
    numbering("I.1.1", a.first(), a.at(1), a.last())
  } else if a.len() == 2 {
    numbering("I.1", ..a)
  } else {
    numbering("1", ..a)
  }
}

// * numbering starts a fresh at base:base-level with last-entry as prefix
#let _derived-dis(..args) = {
  let a = args.pos()
  if a.len() >= 3 {
    numbering("1.1", a.at(-2), a.last())
  } else {
    // this case should never happen but still
    numbering("1", a.last())
  }
}

// * refernece is prefixed by the first, second, last level of the base
#let _derived-ref(..args) = {
  let a = args.pos()
  if a.len() >= 4 {
    numbering("I.1.1.1", a.first(), a.at(-3), a.at(-2), a.last())
  } else if a.len() == 3 {
    numbering("I.1.1", a.first(), a.at(-2), a.last())
  } else {
    numbering("I.1", a.first(), a.last())
  }
}

// * theorem environments
#let _thmbox-defaults = (radius: 0em, inset: (x: 0.5em, y: 0.65em), separator: [.#h(0.2em)])

// * creates new consistent environments
#let make-thm(identifier, head, color, base: "heading", ..extra) = {
  let heading-based = base == "heading"
  thmbox(
    identifier,
    head,
    .._thmbox-defaults,
    base: base,
    base_level: if heading-based { 2 } else { none },
    fill: color.bg,
    stroke: (left: color.border + 2.5pt),
    ..extra,
  ).with(
    numbering: if heading-based { _last-level-dis } else { _derived-dis },
    refnumbering: if heading-based { _last-level-ref } else { _derived-ref },
  )
}

/// Numbered proposition environment. Resets at each level-2 heading.
#let prop = make-thm("proposition", "Proposition", colors.prop)
/// Numbered lemma environment. Resets at each level-2 heading.
#let lemma = make-thm("lemma", "Lemma", colors.lemma)
/// Numbered corollary environment. Numbered relative to its parent proposition.
#let corollary = make-thm("corollary", "Corollary", colors.corollary, base: "proposition")
/// Numbered definition environment. Resets at each level-2 heading.
#let definition = make-thm("definition", "Definition", colors.definition, padding: (top: 0em, bottom: 0em))
/// Unnumbered solution environment: a plain, colored "Solution." label (set
/// slightly larger than body text) with no box; the body is set in a darker
/// shade of the same color, for readable contrast against white.
#let solution = thmplain(
  "solution",
  "Solution",
  inset: 0em,
  separator: [.#h(0.2em)],
  titlefmt: title => text(fill: colors.solution.border, size: 1.15em, weight: "bold", title),
  bodyfmt: body => text(fill: colors.solution.text, body),
).with(numbering: none)

/// Unnumbered example environment.
#let example = thmplain("example", "Example", inset: 0em, separator: [.#h(0.2em)]).with(numbering: none)
/// Unnumbered remark environment.
#let remark = thmplain("remark", "Remark", inset: 0em, separator: [.#h(0.2em)]).with(numbering: none)
/// Proof environment attached to propositions, with a trailing QED square.
#let proof = thmproof("proof", "Proof", base: "proposition", inset: (x: 0.5em, y: 0em), bodyfmt: body => [#body \ #h(
    1fr,
  ) $square$])

// * math conveniences.

/// Arrow: $->$
#let to = $->$
/// Long double-headed arrow: $<=>$
#let iff = $arrow.long.double.l.r$
/// Long double arrow: $=>$
#let implies = $arrow.double.long$
/// Inner product $angle.l x, y angle.r$.
///
/// - x (content): Left argument.
/// - y (content): Right argument.
#let inner(x, y) = $lr(angle.l #x, #y angle.r)$
/// Identity morphism/map: $"id"$
#let id = $"id"$
/// Equivalence relation operator (tilde, classed as a relation).
#let rel = math.op(math.tilde)

#import "algo.typ"
#import "cat.typ"
#import "convex.typ"
#import "prob.typ"

#let _prob-state = state("problem-label", (0, none))

#let _parse-prob-label(label) = {
  let parts = label.split(".")
  if parts.len() == 1 and parts.at(0).match(regex("^\d+$")) != none {
    (int(parts.at(0)), none)
  } else if (
    parts.len() == 2 and parts.at(0).match(regex("^\d+$")) != none and parts.at(1).match(regex("^\d+$")) != none
  ) {
    (int(parts.at(0)), int(parts.at(1)))
  } else {
    none
  }
}

/// A problem block rendered as a bordered box whose top edge is interrupted
/// by the bold header, e.g. `Problem 3. Title. ----------------`.
///
/// Numbering is automatic and persistent across the document. Providing a
/// numeric label like `"3"` or `"3.1"` resets the counter to that value and
/// subsequent unlabeled problems increment accordingly (`4`, `5`, ... or
/// `3.2`, `3.3`, ...). Non-numeric labels (e.g. `"EC"`) are displayed as-is
/// without affecting the counter.
///
/// - label (str): Optional label. Numeric labels reset the counter; arbitrary labels display verbatim.
/// - title (content): Optional title shown after the problem number, as "Problem N. Title."
/// - boxed (bool): Whether to draw the bordered box (default: `true`). When `false`, renders as a plain bold header with an indented body.
/// - body (content): Problem content, rendered inside the box.
#let problem(label: none, title: none, boxed: true, body) = {
  if label != none {
    let parsed = _parse-prob-label(label)
    if parsed != none { _prob-state.update(parsed) }
  } else {
    _prob-state.update(((maj, min)) => {
      if min == none { (maj + 1, none) } else { (maj, min + 1) }
    })
  }
  context {
    let num = if label != none {
      label
    } else {
      let (maj, min) = _prob-state.get()
      if min == none { str(maj) } else { str(maj) + "." + str(min) }
    }
    let header = if title != none {
      [Problem #num. #title.]
    } else {
      [Problem #num.]
    }
    let header-text = text(size: 13pt, weight: "bold", header)

    if not boxed {
      block(above: 1.2em, below: 0.6em)[#header-text]
      pad(left: 1em, body)
      v(1em, weak: true)
    } else {
      layout(size => {
        // the title tag is measured so the box's top inset and the gap
        // before it can grow to fit titles that wrap onto multiple lines;
        // titles that fit on one line get a shrink-to-fit tag instead of a
        // full-width one, so the border resumes right after the text.
        let avail-width = size.width - 2.4 * 13pt
        let natural = measure(header-text)
        let title-box = if natural.width <= avail-width {
          box(fill: white, inset: (x: 0.35em, y: 0.15em), header-text)
        } else {
          box(width: avail-width, fill: white, inset: (x: 0.35em, y: 0.15em), header-text)
        }
        let dims = measure(title-box)
        let gap-below = 0.55em
        let top-inset = dims.height / 2 + gap-below
        let dy = -(dims.height + gap-below)

        [
          #v(0.85em + dims.height / 2)
          #block(
            width: 100%,
            stroke: 0.6pt + black,
            radius: 2pt,
            inset: (top: top-inset, bottom: 0.9em, x: 1em),
            breakable: true,
          )[
            #place(top + left, dx: 0.6em, dy: dy)[#title-box]
            #body
          ]
          #v(0.6em)
        ]
      })
    }
  }
}

/// Forces a math block onto its own line, preceded by a blank line.
/// Useful when a display equation needs to break out of a tight paragraph.
#let math-fw(body) = block[\ #box(width: 100%)[#body]]

/// Inline highlight with a pale yellow background.
///
/// - body (content): Content to highlight.
/// - color (color): Background color (default: pale yellow).
#let highlight(body, color: rgb("#FEF2A0")) = {
  box(
    fill: color,
    inset: (x: 0.1em, y: 0em),
    outset: (y: 0.15em),
    radius: 0.12em,
    body,
  )
}
