/*
 * Typst template for papers to be published with JACoW
 *
 * Based on the JACoW guide for preparation of papers.
 * See https://jacow.org/ for more information.
 * Requires Typst version 0.12 for compiling
 *
 * This document is licensed under the GNU General Public License 3
 * https://www.gnu.org/licenses/gpl-3.0.html
 *
 * Copyright (c) 2024 Philipp Niedermayer (github.com/eltos)
 * This file is part of the accelerated-jacow template.
 * Typst universe: https://typst.app/universe/package/accelerated-jacow
 * GitHub repository: https://github.com/eltos/accelerated-jacow
 */

#import "@preview/zero:0.3.0"
#import "@preview/datify:1.0.1": *

#let jacow(
  title: "Title goes here",
  subtitle: "",
  authors: (),
  abstract: none,
  date: datetime.today(),
  // funding: none,
  body,
) = {
  authors = authors.filter(a => "name" in a.keys())

  // sort authors: corresponding first, then alphabetic by last name
  authors = authors.sorted(key: a => if "email" in a { " " } + a.name.split(" ").last())


  /// Helper for custom footnote symbols
  let titlenotenumbering(i) = {
    if i < 6 { ("*", "#", "§", "¶", "‡").at(i - 1) } else { (i - 4) * "*" }
  }

  /// Capitalize all characters in the text, e.g. "THIS IS AN ALLCAPS HEADING"
  let allcaps = upper

  /// Capitalize major words, e.g. "This is a Word-Caps Heading"
  let wordcaps(body) = {
    if body.has("text") {
      let txt = lower(body.text)
      let words = txt.matches(regex("^()(\\w+)")) // first word
      words += txt.matches(regex("([.:;?!]\s+)(\\w+)")) // words after punctuation
      words += txt.matches(regex("()(\\w{4,})")) // words with 4+ letters
      for m in words {
        let (pre, word) = m.captures
        word = upper(word.at(0)) + word.slice(1)
        txt = txt.slice(0, m.start) + pre + word + txt.slice(m.end)
      }
      txt
    } else if body.has("children") {
      body.children.map(it => wordcaps(it)).join()
    } else {
      body
    }
  }

  // Capitalize subtitle correctly
  subtitle = wordcaps(subtitle)
  date = custom-date-format(date, lang: "pl", pattern: "d MMMM yyyy")


  // metadata

  set document(title: title, author: authors.map(author => author.name))


  // layout

  set page(
    columns: 1,
    paper: "a4",
    margin: (top: 20mm, bottom: 20mm, x: 20mm),
    header: context {
      if counter(page).get().first() > 1 {
        grid(
          columns: (1fr, 1fr),
          align: (left, right),
          text(weight: "bold")[#title], subtitle,
        )
        line(stroke: 0.5pt, length: 100%)
      }
    },
    footer: context {
      if counter(page).get().first() > 1 {
        line(stroke: 0.5pt, length: 100%)
      }
      grid(
        columns: (1fr, 1fr),
        align: (left, right),
        date, counter(page).display("1/1", both: true),
      )
    },
  )

  show link: set text(
    fill: rgb("#0645AD"),
  )

  set columns(gutter: 0.2in)

  set text(
    // font: "TeX Gyre Termes",
    size: 10pt,
  )

  set par(
    first-line-indent: 1em,
    justify: true,
    spacing: 1.2em,
    leading: 0.5em,
  )


  // Note: footnotes not working in parent scoped placement with two column mode.
  // See https://github.com/typst/typst/issues/1337#issuecomment-1565376701
  // As a workaround, we handle footnotes in the title area manually.
  // An alternative is to not use place and use "show: columns.with(2, gutter: 0.2in)" after the title area instead of "page(columns: 2)",
  // but then footnotes span the full page and not just the left column.
  //let titlefootnote(text) = { footnote(numbering: titlenotenumbering, text) }
  let footnotes = state("titlefootnotes", (:))
  let titlefootnote(text) = {
    footnotes.update(footnotes => {
      footnotes.insert(titlenotenumbering(footnotes.len() + 1), text)
      footnotes
    })
    h(0pt, weak: true)
    context { super(footnotes.get().keys().at(-1)) }
  }

  show footnote.entry: set align(left)
  set footnote.entry(
    indent: 0em,
    separator: [
      #set align(left)
      #line(length: 40%, stroke: 0.5pt)
    ],
  )


  place(
    horizon + center,
    // scope: "parent",
    // float: true,
    {
      stack(
        spacing: 4em,
        // Title
        text(size: 40pt, weight: "bold", hyphenate: false, { title }),
        // Subtitle
        text(size: 20pt, weight: "medium", hyphenate: false, { subtitle }),
        // Authors
        text(size: 12pt, hyphenate: false, {
          let count = calc.min(authors.len(), 4)
          grid(
            columns: (1fr,) * count,
            row-gutter: 20pt,
            ..authors.map(a => a.name + "\n" + emph(a.studentID)),
          )
        }),
      )
    },
  )

  context {
    for (symbol, text) in footnotes.get() {
      place(footnote(numbering: it => "", { super(symbol) + " " + text }))
    }
  }


  /*
   * Contents
   */

  // paragraph
  set align(left)
  //show: columns.with(2, gutter: 0.2in)

  set heading(numbering: "1.1.1.1 ")
  // SECTION HEADINGS
  show heading.where(level: 1): it => {
    set align(left)
    set text(size: 12pt, weight: "bold", style: "normal", hyphenate: false)
    counter(math.equation).update(0)
    block(
      below: 1em,
      allcaps(counter(heading).display() + ". " + it.body),
    )
  }

  // Subsection Headings
  show heading.where(level: 2): it => {
    set align(left)
    set text(size: 12pt, weight: "regular", style: "italic", hyphenate: false)
    set par(first-line-indent: 0pt)
    wordcaps(it.body)
    v(0pt)
  }

  // Third-Level Headings
  show heading.where(level: 3): it => {
    v(0.5em)
    set text(size: 10pt, weight: "bold", style: "normal")
    set par(first-line-indent: 0pt)
    wordcaps(it.body)
    v(0pt)
  }

  // lists
  show list: set list(indent: 1em)

  // figures
  // show figure: set figure(placement: auto)
  show figure: set figure(placement: none)
  show figure.caption: it => {
    set text(size: 0.8em)
    set par(first-line-indent: 0em)
    layout(size => context {
      align(
        // center for single-line, left for multi-line captions
        if measure(it).width < size.width { center } else { left },
        block(width: size.width, it),
      )
    })
  }

  // tables
  show figure.where(
    kind: table,
  ): set figure.caption(position: top)

  // references
  set ref(supplement: it => {
    box(
      if it.func() == figure and it.kind == image {
        "Fig."
      } else if it.func() == math.equation {
        "" // Remove the default Equation caption
      } else {
        it.supplement
      },
    )
  })
  //set math.equation(supplement: "Wzor")

  pagebreak()

  // abstract
  if abstract != none [
    == Wprowadzenie
    #abstract
  ]

  // references
  show bibliography: set text(9pt)
  //set bibliography(title: [References], style: "jacow.csl")
  show link: it => text(
    // font: "DejaVu Sans Mono",
    size: 7.2pt,
    it,
  )


  let eq_numbering(num) = {
    box(
      // h(-3pt) removes the space that gets inserted automatically when referencing
      h(-3pt) + "Wzór " + counter(heading.where(level: 1)).display() + "." + [#num],
    )
  }

  // automatically number labeled equation
  show: body => {
    for elem in body.children {
      if elem.func() == math.equation and elem.block and "label" in elem.fields() {
        // set math.equation(numbering: "Wzór 1.")
        set math.equation(numbering: eq_numbering)
        elem
      } else {
        elem
      }
    }
  }

  let formatted_table(columnsCount: 0, cells, ..args) = {
    table(
      // stroke: none,
      stroke: (x, y) => { if y == 0 { (bottom: black + 0.7pt) } else { none } },
      columns: 4,
      align: (x, y) => {
        if x == 0 { left } else { center } + bottom
      },
      table.hline(),

      [ #xUnit $arrow$\ #yUnit $arrow.b$],
      ..cells,

      table.hline(),
    )
  }

  body
}

// TODO FIX THIS
// to be formatted along with source material
// #let table_units(x: none, y: none) = {
//   [
//     #if(x != none){[#x $arrow$]}
//     \
//     #if(y != none){[#y $arrow.b$]}
//   ]
// }

#let formatted_table_sep = table.hline(stroke: black + 0.4pt)

#let formatted_table(
  caption: none,
  columnsCount: none,
  ref: none,
  ..args,
  cells,
) = {
  set table.cell(breakable: false)
  [
    #figure(
      kind: table,
      caption: caption,
      zero.ztable(
        stroke: (x, y) => { if y == 0 { (bottom: black + 0.7pt) } else { none } },
        columns: (columnsCount),
        align: horizon + center,
        ..args,
        table.hline(),
        ..cells,
        table.hline(),
      ),
    )
    #if ref != none {
      label(ref)
    }
  ]
}

// #formatted_table(columnsCount: 4,
//     (
//     []        [xsdd],[*y*],[*z*],
//     [First],  [1], [0.3], [14],
//     [Second], [2], [0.4], [023],
//     [Third],  [3], [0.8])
//     )

// #formatted_table(columnsCount: 3,
//   (
//     [sadasdasdasd],[b],[c],
//     [9],[b],[c],
//     [a],[b],[c],
//     [a],[b],[c],
//     [a],[b],[c],
//   ))


// #formatted_table(columnsCount: 3,
//   (
//     [sadasdasdasd],[b],[c],
//     [9],[b],[c],
//     [a],[b],[c],
//     formatted_table_sep,
//     [a],[b],[c],
//     formatted_table_sep,
//     [a],[b],[c],
//   ))

// Note: Not working currently, ignore
// #formatted_table(columnsCount: 3,
//     (table_units(x:"123", y:"345"),   [xsdd],[*y*],[*z*],
//     [First], [1], [0.3], [14],
//     [Second], [2], [0.4], [023],
//     [Third], [3], [0.8])
//   )


#let eq_numbering(num) = {
  box(
    // h(-3pt) removes the space that gets inserted automatically when referencing
    h(-3pt) + "Wzór " + counter(heading.where(level: 1)).display() + "." + [#num],
  )
}

#let equation_with_description(
  equation,
  ..args,
) = {
  figure(
    // the if is a fix to allow for equation numbering
    if equation.has("children") and equation.children.any(eq => eq.has("label")) {
      set math.equation(numbering: eq_numbering)
      equation
    } else { equation },

    caption: {
      grid(
        columns: 1,
        gutter: 0.5em,
        align: (x, y) => {
          if (y == 0) { center } else { left }
        },
        [Gdzie:],
        ..args,
      )
    },
    numbering: none,
  )
}

// EXAMPLE: (label is optional)
// #equation_with_description(
//   [$ F_g = m dot g $ <eq:gravitational_force>],
//   [$a$ – przyspieszenia ciała,],
//   [$g$ – przyspieszenie ziemskie],
//   [$alpha$ - kąt nachylenia równi.]
// )

