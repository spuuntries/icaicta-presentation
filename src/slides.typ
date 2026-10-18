#import "@preview/touying:0.7.4": *
#import "colors.typ": *
#import "fonts.typ": *
#import "components.typ": corner-flag, badge, its-logo, if-logo, its-tower, its-batik

/// Title slide for conference paper presentation or academic seminar
#let title-slide(
  title: auto,
  subtitle: none,
  author: auto,
  authors: auto,
  institution: auto,
  date: auto,
  conference: [ICAICTA 2026],
  paper-id: none,
  session: none,
  tags: (),
  tag-style: "line", // "line" | "kicker" | "subtle" | "pill" | "none"
  variant: "white", // "white" | "blue" | "dark"
  extra: none,
  show-tower: true,
  ..args,
) = touying-slide-wrapper(self => {
  let fonts = self.store.at("fonts", default: default-font-presets.academic)
  let is-blue = variant == "blue"
  let is-dark = variant == "dark" or is-blue

  let bg-color = if is-blue {
    if-blue-deep
  } else if variant == "dark" {
    if-blue-dark
  } else {
    if-bg
  }

  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      fill: bg-color,
      background: corner-flag(dark: is-dark, size-scale: 1.0),
      header: none,
      footer: none,
      margin: (x: 1.5cm, top: 1.0cm, bottom: 1.2cm),
    ),
  )

  let info-title = if title != auto { title } else { self.info.at("title", default: "") }
  let info-subtitle = if subtitle != none { subtitle } else { self.info.at("subtitle", default: none) }
  let author-val = if authors != auto { authors } else if author != auto { author } else { self.info.at("author", default: none) }
  let info-inst = if institution != auto { institution } else { self.info.at("institution", default: [Departemen Teknik Informatika, Institut Teknologi Sepuluh Nopember]) }
  let info-date = if date != auto { date } else { utils.display-info-date(self) }

  let body = {
    // Background watermark / tower illustration
    if show-tower {
      place(
        right + bottom,
        dx: 1.2cm,
        dy: 1.2cm,
        image("assets/its-tower-blue.png", height: 10.2cm)
      )
    }

    set align(left + horizon)

    // Top Header Row spanning the full slide width
    grid(
      columns: (auto, 1fr),
      gutter: 1.0em,
      align: horizon,
      image(if is-dark { "assets/if-logo-white.png" } else { "assets/if-logo-blue.png" }, height: 1.5em),
      align(right)[
        #if conference != none [
          #box(
            fill: if is-dark { rgb("#ffffff22") } else { if-blue-light },
            radius: 100pt,
            inset: (x: 0.65em, y: 0.22em),
            stroke: if is-dark { 0.5pt + white.lighten(30%) } else { 0.5pt + if-blue.lighten(60%) },
            text(
              font: fonts.accent,
              fill: if is-dark { if-gold } else { if-blue },
              size: 0.64em,
              weight: "bold",
            )[#conference]
          )
        ]
      ]
    )

    v(0.8em)

    // Main Content Block constrained to 72% so it never collides with tower
    block(
      width: 72%,
      [
        // Tag / Session / Metadata Line
        #if tag-style == "line" [
          #{
            let parts = ()
            if paper-id != none { parts.push([Paper \##paper-id]) }
            if session != none { parts.push(session) }
            for t in tags { parts.push(t) }
            if parts.len() > 0 [
              #set text(
                font: fonts.accent,
                fill: if is-dark { if-gold } else { if-blue },
                size: 0.74em,
                weight: "bold",
              )
              #parts.join([ #h(0.4em) #text(fill: if is-dark { rgb("#ffffff44") } else { if-slate })[·] #h(0.4em) ])
              #v(0.45em)
            ]
          }
        ] else if tag-style == "kicker" [
          #grid(
            columns: (auto, 1fr),
            gutter: 0.8em,
            align: horizon,
            if paper-id != none [
              #box(
                fill: if is-dark { if-gold } else { if-blue },
                radius: 3pt,
                inset: (x: 0.5em, y: 0.22em),
                text(font: fonts.accent, fill: if is-dark { if-blue-dark } else { white }, size: 0.72em, weight: "bold")[Paper \##paper-id]
              )
            ],
            [
              #set text(font: fonts.accent, size: 0.74em)
              #if session != none [
                #text(fill: if is-dark { white } else { if-text }, weight: "bold")[#session]
              ]
              #if tags.len() > 0 [
                #if session != none [ #h(0.4em) #text(fill: if-slate)[·] #h(0.4em) ]
                #text(fill: if is-dark { if-gold-light } else { if-text-muted })[#tags.join([ · ])]
              ]
            ]
          )
          #v(0.45em)
        ] else if tag-style == "subtle" [
          #{
            let items = ()
            if paper-id != none {
              items.push(box(
                fill: if is-dark { rgb("#ffffff20") } else { if-blue-light },
                radius: 4pt,
                inset: (x: 0.55em, y: 0.22em),
                stroke: 0.5pt + (if is-dark { white.lighten(20%) } else { if-blue.lighten(60%) }),
                text(font: fonts.accent, fill: if is-dark { if-gold } else { if-blue }, size: 0.7em, weight: "bold")[Paper \##paper-id]
              ))
            }
            if session != none {
              items.push(box(
                fill: if is-dark { rgb("#ffffff15") } else { if-slate-light },
                radius: 4pt,
                inset: (x: 0.55em, y: 0.22em),
                stroke: 0.5pt + (if is-dark { white.lighten(10%) } else { if-border }),
                text(font: fonts.accent, fill: if is-dark { white } else { if-text }, size: 0.7em, weight: "medium")[#session]
              ))
            }
            for t in tags {
              items.push(box(
                fill: if is-dark { rgb("#ffffff10") } else { if-bg-soft },
                radius: 4pt,
                inset: (x: 0.55em, y: 0.22em),
                stroke: 0.5pt + if-border,
                text(font: fonts.accent, fill: if is-dark { rgb("#CBD5E1") } else { if-text-muted }, size: 0.7em)[#t]
              ))
            }
            if items.len() > 0 [
              #stack(dir: ltr, spacing: 0.4em, ..items)
              #v(0.5em)
            ]
          }
        ] else if tag-style == "pill" [
          #{
            let items = ()
            if paper-id != none {
              items.push(box(
                fill: if is-dark { if-gold } else { if-blue-dark },
                radius: 100pt,
                inset: (x: 0.6em, y: 0.22em),
                text(font: fonts.accent, fill: if is-dark { if-blue-dark } else { white }, size: 0.7em, weight: "bold")[Paper \##paper-id]
              ))
            }
            if session != none {
              items.push(box(
                fill: if is-dark { rgb("#ffffff1e") } else { if-gold-light },
                radius: 100pt,
                inset: (x: 0.6em, y: 0.22em),
                text(font: fonts.accent, fill: if is-dark { if-gold } else { if-gold-dark }, size: 0.7em, weight: "bold")[#session]
              ))
            }
            for t in tags {
              items.push(box(
                fill: if is-dark { rgb("#ffffff15") } else { if-slate-light },
                radius: 100pt,
                inset: (x: 0.6em, y: 0.22em),
                text(font: fonts.accent, fill: if is-dark { white } else { if-text }, size: 0.7em, weight: "bold")[#t]
              ))
            }
            if items.len() > 0 [
              #stack(dir: ltr, spacing: 0.4em, ..items)
              #v(0.5em)
            ]
          }
        ]

        // Main Paper Title with ITS indicator stroke
        #block(
          stroke: (left: 4.5pt + if is-dark { if-gold } else { if-blue }),
          inset: (left: 0.8em),
          [
            #block[
              #set text(
                font: fonts.heading,
                size: 1.85em,
                weight: "bold",
                fill: if is-dark { white } else { if-blue-dark },
              )
              #set par(leading: 0.25em)
              #info-title
            ]
            #if info-subtitle != none [
              #v(0.35em)
              #text(
                font: fonts.body,
                size: 1.0em,
                weight: "medium",
                fill: if is-dark { if-gold-light } else { if-blue },
                info-subtitle,
              )
            ]
          ]
        )

        #v(0.7em)

        // Authors & Affiliations
        #block[
          #set text(font: fonts.body, size: 0.84em)
          #if author-val != none [
            #text(
              font: fonts.heading,
              weight: "bold",
              fill: if is-dark { white } else { if-text },
              author-val,
            )
          ]
          #if info-inst != none [
            #v(0.2em)
            #text(
              font: fonts.body,
              fill: if is-dark { rgb("#E2E8F0") } else { if-text-muted },
              size: 0.88em,
              info-inst,
            )
          ]
          #if info-date != none [
            #v(0.2em)
            #text(
              font: fonts.accent,
              fill: if is-dark { if-gold } else { if-text-light },
              size: 0.8em,
              weight: "medium",
              info-date,
            )
          ]
          #if extra != none [
            #v(0.4em)
            #extra
          ]
        ]
      ]
    )
  }

  touying-slide(self: self, repeat: 1, body)
})

/// Outline / Agenda roadmap slide
#let outline-slide(
  title: [Presentation Outline],
  depth: 1,
  ..args,
) = touying-slide-wrapper(self => {
  let self = utils.merge-dicts(self, config-store(
    current-slide-title: title,
  ))
  touying-slide(
    self: self,
    [
      #v(0.5em)
      #set outline(title: none, indent: 1.2em, depth: depth)
      #show outline.entry: it => {
        text(fill: if-text, weight: "medium", size: 1.05em, it)
      }
      #outline(..args)
    ]
  )
})

/// Section divider slide (Chapter / Module Divider)
#let section-slide(
  title: auto,
  subtitle: none,
  number: auto,
  level: 1,
  variant: "white", // "white" | "blue" | "dark"
  config: (:),
  ..args,
) = touying-slide-wrapper(self => {
  let is-blue = variant == "blue"
  let is-dark = variant == "dark" or is-blue

  let bg-color = if is-blue {
    if-blue-deep
  } else if variant == "dark" {
    if-blue-dark
  } else {
    if-bg
  }

  self = utils.merge-dicts(
    self,
    config-page(
      fill: bg-color,
      background: corner-flag(dark: is-dark, size-scale: 1.0),
      header: none,
      footer: none,
      margin: (x: 2.2cm, y: 1.8cm),
    ),
  )

  let display-title = if title != auto and title != none {
    title
  } else {
    utils.display-current-heading(level: level)
  }

  let sec-num = if number != auto {
    number
  } else {
    context {
      let sec = query(heading.where(level: 1)).filter(h => h.location().page() <= here().page())
      if sec.len() > 0 {
        let n = sec.len()
        if n < 10 { "0" + str(n) } else { str(n) }
      } else { "01" }
    }
  }

  let fonts = self.store.at("fonts", default: default-font-presets.academic)

  let content = {
    // Subtle background watermark
    place(
      right + horizon,
      dx: 1.5cm,
      image("assets/its-tower-blue.png", width: 8.5cm)
    )

    set align(left + horizon)

    grid(
      columns: (auto, 1fr),
      column-gutter: 1.2cm,
      align: (left + horizon, left + horizon),
      [
        // Big Section Number Pill
        #box(
          fill: if is-dark { if-gold } else { if-blue },
          radius: 10pt,
          inset: (x: 0.75em, y: 0.55em),
          text(
            font: fonts.accent,
            fill: if is-dark { if-blue-dark } else { white },
            size: 2.8em,
            weight: "black",
          )[#sec-num]
        )
      ],
      [
        #block[
          #set text(
            font: fonts.heading,
            size: 2.2em,
            weight: "bold",
            fill: if is-dark { white } else { if-blue-dark },
          )
          #set par(leading: 0.28em)
          #display-title
        ]
        #if subtitle != none [
          #v(0.35em)
          #text(
            font: fonts.body,
            size: 1.15em,
            fill: if is-dark { if-gold-light } else { if-text-muted },
          )[#subtitle]
        ]
        #let extra = args.pos().filter(it => it != none and it != [])
        #if extra.len() > 0 [
          #v(0.8em)
          #extra.first()
        ]
      ]
    )
  }

  touying-slide(self: self, repeat: 1, content)
})

/// Standout focus slide with high-contrast background
#let focus-slide(
  title: none,
  bg: if-blue-dark,
  ..args,
  body,
) = touying-slide-wrapper(self => {
  let fonts = self.store.at("fonts", default: default-font-presets.academic)

  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      fill: bg,
      background: corner-flag(dark: true, size-scale: 1.0),
      header: none,
      footer: none,
      margin: 2.5cm,
    ),
  )

  let content = {
    set align(center + horizon)
    set text(font: fonts.body, fill: white, size: 1.55em)

    block(
      width: 85%,
      [
        #if title != none [
          #text(font: fonts.heading, size: 1.35em, weight: "bold", fill: if-gold)[#title]
          #v(0.8em)
        ]
        #body
      ]
    )
  }

  touying-slide(self: self, repeat: 1, content)
})

/// Two-column comparison slide (matching PPT Layout 8 & 11)
#let comparison-slide(
  title: auto,
  left-title: [Baseline / Approach A],
  right-title: [Proposed / Approach B],
  left-body,
  right-body,
  ..args,
) = touying-slide-wrapper(self => {
  let self = utils.merge-dicts(self, config-store(
    current-slide-title: title,
  ))
  let fonts = self.store.at("fonts", default: default-font-presets.academic)

  touying-slide(
    self: self,
    [
      #grid(
        columns: (1fr, 1fr),
        gutter: 1.4em,
        block(
          width: 100%,
          [
            #box(
              fill: if-blue-light,
              radius: 6pt,
              inset: (x: 0.8em, y: 0.4em),
              stroke: 0.5pt + if-blue.lighten(50%),
              width: 100%,
              text(font: fonts.heading, weight: "bold", fill: if-blue, size: 0.95em)[#left-title]
            )
            #v(0.35em)
            #left-body
          ]
        ),
        block(
          width: 100%,
          [
            #box(
              fill: if-gold-light,
              radius: 6pt,
              inset: (x: 0.8em, y: 0.4em),
              stroke: 0.5pt + if-gold.darken(20%),
              width: 100%,
              text(font: fonts.heading, weight: "bold", fill: if-gold-dark, size: 0.95em)[#right-title]
            )
            #v(0.35em)
            #right-body
          ]
        )
      )
    ]
  )
})

/// Closing & Q&A slide modeled after PPT Layout 13
#let thank-you-slide(
  title: [Terima Kasih / Thank You],
  subtitle: [Questions & Discussion],
  author: auto,
  email: none,
  repo: none,
  paper-link: none,
  quote: none,
  variant: "blue", // "blue" | "dark" | "white"
  ..args,
) = touying-slide-wrapper(self => {
  let is-blue = variant == "blue"
  let is-dark = variant == "dark" or is-blue

  let bg-color = if is-blue {
    if-blue-deep
  } else if variant == "dark" {
    if-blue-dark
  } else {
    if-bg
  }

  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      fill: bg-color,
      background: corner-flag(dark: is-dark, size-scale: 1.0),
      header: none,
      footer: none,
      margin: (x: 2.2cm, top: 1.3cm, bottom: 1.1cm),
    ),
  )

  let fonts = self.store.at("fonts", default: default-font-presets.academic)
  let author-val = if author != auto { author } else { self.info.at("author", default: "") }

  let content = {
    // Background tower art
    place(
      right + horizon,
      dx: 1.2cm,
      image("assets/its-tower-gold.png", height: 9.2cm)
    )

    set align(left + horizon)

    block(
      width: 74%,
      [
        // Logos
        #image(if is-dark { "assets/if-logo-white.png" } else { "assets/if-logo-blue.png" }, height: 1.55em)

        #v(0.6em)

        #stack(
          spacing: 0.35em,
          text(
            font: fonts.heading,
            size: 2.1em,
            weight: "bold",
            fill: if is-dark { white } else { if-blue-dark },
          )[#title],
          if subtitle != none {
            text(
              font: fonts.body,
              size: 1.15em,
              weight: "medium",
              fill: if is-dark { if-gold } else { if-blue },
            )[#subtitle]
          },
        )

        #v(0.45em)

        // Contact info / links
        #block[
          #set text(font: fonts.body, size: 0.85em, fill: if is-dark { white } else { if-text })
          #if author-val != "" [
            *#author-val* \
          ]
          #if email != none [
            #text(fill: if is-dark { if-gold-light } else { if-blue })[✉ #email] \
          ]
          #if repo != none [
            #text(fill: if is-dark { if-gold-light } else { if-blue })[🔗 #repo] \
          ]
          #if paper-link != none [
            #text(fill: if is-dark { if-gold-light } else { if-blue })[📄 #paper-link] \
          ]
        ]

        #if quote != none [
          #v(0.6em)
          #block(
            width: 90%,
            stroke: (left: 3.5pt + if-gold),
            inset: (left: 0.7em, y: 0.3em),
            text(
              font: fonts.body,
              style: "italic",
              fill: if is-dark { rgb("#CBD5E1") } else { if-text-muted },
              size: 0.8em,
            )[“#quote”]
          )
        ]
      ]
    )
  }

  touying-slide(self: self, repeat: 1, content)
})

/// Blank slide for fullscreen diagrams or live demos
#let blank-slide(..args, body) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-page(
      header: none,
      footer: none,
      margin: 1cm,
    ),
  )
  touying-slide(self: self, align(center + horizon, body), ..args)
})

/// Standard slide with header and footer
#let slide(
  title: auto,
  subtitle: none,
  quote: none,
  alignment: top + left,
  ..args,
) = touying-slide-wrapper(self => {
  let named = args.named()
  let self = utils.merge-dicts(self, config-store(
    current-slide-title: title,
    current-slide-subtitle: subtitle,
  ))

  set align(alignment)

  if quote != none {
    let rest-composer = named.remove("composer", default: auto)
    let quote-composer = (..composer-args) => {
      let composer-bodies = composer-args.pos()
      quote-block(quote)
      if type(rest-composer) == function {
        rest-composer(..composer-bodies)
      } else {
        components.side-by-side(columns: rest-composer, ..composer-bodies)
      }
    }
    touying-slide(self: self, composer: quote-composer, ..args.pos(), ..named)
  } else {
    touying-slide(self: self, ..args)
  }
})
