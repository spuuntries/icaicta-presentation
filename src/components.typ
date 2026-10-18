#import "@preview/touying:0.7.4": *
#import "@preview/showybox:2.0.4": showybox
#import "colors.typ": *
#import "fonts.typ": if-fonts-state

/// Signature ITS IF top-left corner flag
#let corner-flag(dark: false, size-scale: 1.0) = {
  let primary-fill = if dark { white } else { if-blue }
  let yellow-fill = if-gold
  place(
    top + left,
    dx: 0pt,
    dy: 0pt,
    stack(
      dir: ltr,
      spacing: 0pt,
      // Overlapping accent notches matching the PPT layout
      rect(
        width: 2.2cm * size-scale,
        height: 0.28cm * size-scale,
        fill: yellow-fill,
      ),
      rect(
        width: 0.8cm * size-scale,
        height: 0.28cm * size-scale,
        fill: primary-fill,
      ),
    )
  )
}

/// ITS and Teknik Informatika Logo Helpers
#let its-logo(height: 1.3em, white: false) = {
  image(
    if white { "assets/its-logo-white.png" } else { "assets/its-logo-blue.png" },
    height: height,
  )
}

#let if-logo(height: 1.3em, white: false) = {
  image(
    if white { "assets/if-logo-white.png" } else { "assets/if-logo-blue.png" },
    height: height,
  )
}

#let its-tower(height: 6cm, gold: false) = {
  image(
    if gold { "assets/its-tower-gold.png" } else { "assets/its-tower-blue.png" },
    height: height,
  )
}

#let its-batik(size: 4cm, opacity: 25%) = {
  box(
    width: size,
    height: size,
    image("assets/its-batik.png", width: 100%),
  )
}

/// Paper metadata banner for conference presentation intro
#let paper-meta(
  conference: [ICAICTA 2026],
  track: none,
  paper-id: none,
  session: none,
) = context {
  let f = if-fonts-state.get()
  box(
    fill: if-blue-light,
    radius: 6pt,
    inset: (x: 0.8em, y: 0.5em),
    stroke: 0.5pt + if-blue.lighten(60%),
    [
      #stack(
        dir: ltr,
        spacing: 0.8em,
        [
          #box(
            fill: if-blue,
            radius: 4pt,
            inset: (x: 0.5em, y: 0.2em),
            text(font: f.accent, fill: white, size: 0.75em, weight: "bold")[#conference]
          )
        ],
        if track != none [
          #text(font: f.accent, fill: if-text, size: 0.78em, weight: "bold")[#track]
        ],
        if paper-id != none [
          #text(font: f.accent, fill: if-text-muted, size: 0.75em)[Paper ID: #paper-id]
        ],
        if session != none [
          #text(font: f.accent, fill: if-gold-dark, size: 0.75em, weight: "bold")[#session]
        ]
      )
    ]
  )
}

/// Callout box with academic & paper semantic styles
#let cblock(
  title: none,
  type: "info", // "info", "method", "result", "challenge", "problem", "tip", "warning", "danger", "gold", "cute"
  color: none,
  bg: none,
  border: none,
  radius: 6pt,
  body,
) = {
  let theme = if-semantic.at(type, default: if-semantic.info)
  let bar-color = if color != none { color } else { theme.primary }
  let body-bg = if bg != none { bg } else { theme.bg }
  let border-color = if border != none { border } else { theme.border }

  let title-arg = if title != none [
    #context {
      let f = if-fonts-state.get()
      text(font: f.heading, weight: "bold", size: 0.95em, fill: white)[#title]
    }
  ] else { none }

  showybox(
    title-style: (
      color: white,
      sep-thickness: 0pt,
      align: horizon,
    ),
    frame: (
      radius: radius,
      thickness: 1pt,
      border-color: border-color,
      title-color: bar-color,
      body-color: body-bg,
      inset: (x: 0.85em, y: 0.6em),
    ),
    above: 0.35em,
    below: 0.35em,
    title: title-arg,
    [
      #context {
        let f = if-fonts-state.get()
        set text(font: f.body, fill: if-text, size: 0.9em)
        body
      }
    ]
  )
}

/// Research Question highlight card for academic papers
#let research-question(
  number,
  title: none,
  body,
) = context {
  let f = if-fonts-state.get()
  showybox(
    frame: (
      radius: 6pt,
      thickness: 1.5pt,
      border-color: if-blue,
      title-color: if-blue-dark,
      body-color: if-blue-pale,
      inset: (x: 1em, y: 0.75em),
    ),
    above: 0.4em,
    below: 0.4em,
    title: grid(
      columns: (auto, 1fr),
      gutter: 0.8em,
      align: horizon,
      box(
        fill: if-gold,
        radius: 4pt,
        inset: (x: 0.5em, y: 0.2em),
        text(font: f.accent, fill: if-blue-dark, weight: "black", size: 0.82em)[RQ #number]
      ),
      if title != none [
        #text(font: f.heading, fill: white, weight: "bold", size: 0.95em)[#title]
      ] else [
        #text(font: f.heading, fill: white, weight: "bold", size: 0.95em)[Research Question]
      ]
    ),
    [
      #set text(font: f.body, fill: if-text, size: 0.92em, weight: "medium")
      #body
    ]
  )
}

/// Alias for research question
#let rq-box = research-question

/// Stat / Metric / Result card for benchmarking
#let stat-card(
  value,
  label,
  subtext: none,
  color: if-blue,
  bg: if-surface,
  border-color: if-border,
) = context {
  let f = if-fonts-state.get()
  block(
    fill: bg,
    stroke: 1pt + border-color,
    radius: 6pt,
    inset: (x: 0.9em, y: 0.65em),
    width: 100%,
    [
      #text(font: f.accent, fill: color, size: 1.75em, weight: "bold")[#value] \
      #v(-0.35em)
      #text(font: f.heading, fill: if-blue-dark, size: 0.88em, weight: "bold")[#label]
      #if subtext != none [
        \ #v(0.1em)
        #text(font: f.body, fill: if-text-muted, size: 0.72em)[#subtext]
      ]
    ]
  )
}

/// Alias for stat-card
#let metric-card = stat-card

/// Quote block with a tight left accent and soft background
#let quote-block(body, author: none, color: if-blue) = context {
  let f = if-fonts-state.get()
  block(
    fill: if-blue-pale,
    stroke: (left: 4pt + color),
    radius: (right: 6pt),
    inset: (x: 1.0em, y: 0.6em),
    width: 100%,
    [
      #set text(font: f.body, fill: if-text, style: "italic", size: 0.92em)
      “#body”
      #if author != none [
        #v(0.3em)
        #align(right)[
          #set text(font: f.body, style: "normal", fill: if-text-muted, size: 0.82em, weight: "bold")
          --- #author
        ]
      ]
    ]
  )
}

/// Anonymous IT quote from the PPT template closing slide
#let it-quote = quote-block(
  [Code is like humor; when you have to explain it, it’s probably not that good.],
  author: [Anonymous IT Enthusiast],
  color: if-gold,
)

/// Multi-column layout helper for side-by-side comparisons
#let split(..bodies, columns: auto, gutter: 1.2em, align: top + left) = {
  let list = bodies.pos()
  let cols = if columns == auto { (1fr,) * list.len() } else { columns }
  grid(
    columns: cols,
    gutter: gutter,
    align: align,
    ..list.map(b => block(width: 100%, b))
  )
}

/// Rounded cute pill badge for tags, categories, or status
#let badge(
  label,
  fill: if-slate-light,
  color: if-blue-dark,
  radius: 100pt,
  icon: none,
) = context {
  let f = if-fonts-state.get()
  box(
    fill: fill,
    radius: radius,
    inset: (x: 0.65em, y: 0.25em),
    baseline: 0%,
    [
      #if icon != none [ #icon #h(0.2em) ]
      #text(font: f.accent, fill: color, size: 0.78em, weight: "bold")[#label]
    ]
  )
}

/// Numbered research or methodology pipeline step
#let step(num, title: none, body) = context {
  let f = if-fonts-state.get()
  grid(
    columns: (auto, 1fr),
    column-gutter: 0.8em,
    align: (top + left, top + left),
    box(
      fill: if-blue,
      radius: 100pt,
      inset: (x: 0.6em, y: 0.25em),
      text(font: f.accent, fill: white, size: 0.85em, weight: "bold")[#num]
    ),
    [
      #if title != none [
        #text(font: f.heading, weight: "bold", fill: if-blue-dark)[#title] \
      ]
      #set text(font: f.body, fill: if-text, size: 0.92em)
      #body
    ]
  )
  v(0.3em)
}

/// Speaker note for presenter mode (pdfpc compatible)
#let note(text) = [
  #pdfpc.speaker-note(text)
]
