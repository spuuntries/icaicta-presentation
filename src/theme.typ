#import "@preview/touying:0.7.4": *
#import "@preview/codly:1.3.0": *
#import "colors.typ": *
#import "fonts.typ": *
#import "components.typ": corner-flag, badge, if-logo, its-logo
#import "slides.typ": slide, title-slide, outline-slide, section-slide, focus-slide, blank-slide, comparison-slide, thank-you-slide

#let _if-header(self) = {
  let fonts = self.store.at("fonts", default: default-font-presets.academic)
  let title = self.store.at("current-slide-title", default: auto)
  let hdr = if title != auto {
    title
  } else {
    utils.display-current-heading(level: 2)
  }
  let sec = utils.display-current-heading(level: 1)

  block(
    width: 100%,
    inset: (x: 1.5cm, top: 0pt),
    stack(
      spacing: 0.25em,
      grid(
        columns: (1fr, auto),
        align: (left + horizon, right + horizon),
        [
          #if sec != none and sec != [] and sec != "" [
            #text(font: fonts.accent, size: 0.7em, fill: if-text-muted, weight: "bold")[#sec]
          ]
        ],
        [
          #image("assets/if-logo-blue.png", height: 1.25em)
        ]
      ),
      [
        #if hdr != none and hdr != [] and hdr != "" [
          #box(
            stroke: (left: 4.5pt + if-blue),
            inset: (left: 0.65em, y: 0.05em),
            text(font: fonts.heading, size: 1.25em, weight: "bold", fill: if-blue-dark, hdr)
          )
        ]
      ]
    )
  )
}

#let _if-footer(self) = context {
  let fonts = self.store.at("fonts", default: default-font-presets.academic)
  set text(font: fonts.accent, size: 0.72em, fill: if-text-muted)

  block(
    width: 100%,
    inset: (x: 1.5cm, bottom: 0.35cm),
    [
      // Segmented ITS Color Bar
      #stack(
        dir: ltr,
        line(stroke: 2.5pt + if-blue, length: 2.2em),
        line(stroke: 2.5pt + if-gold, length: 2.2em),
        line(stroke: 2.5pt + if-blue-dark, length: 2.2em),
        line(stroke: 1pt + if-border, length: 100% - 6.6em),
      )

      #v(0.3em)

      #grid(
        columns: (1fr, auto),
        align: (left + horizon, right + horizon),
        [
          #let author = self.info.at("author", default: "")
          #let inst = self.info.at("institution", default: "")
          #let title = self.info.at("title", default: "")
          #if author != "" [ #strong(author) ]
          #if inst != "" [ #h(0.4em) · #h(0.4em) #inst ]
          #if title != "" [ #h(0.4em) · #h(0.4em) #title ]
        ],
        [
          // Rounded pill slide counter
          #box(
            fill: if-blue-dark,
            radius: 100pt,
            inset: (x: 0.7em, y: 0.22em),
            [
              #set text(font: fonts.accent, fill: white, weight: "bold", size: 0.88em)
              #utils.slide-counter.display()
              #text(fill: if-slate, weight: "regular")[ \/ #utils.last-slide-number]
            ]
          )
        ]
      )

      // Optional progress bar along the very bottom
      #if self.store.progress-bar {
        place(
          bottom + left,
          float: true,
          move(dy: 0.4cm)[
            #components.progress-bar(
              height: 2pt,
              if-blue,
              if-border,
            )
          ]
        )
      }
    ]
  )
}

/// Main ITS Teknik Informatika Theme function for Touying presentations
#let if-theme(
  aspect-ratio: "16-9",
  navigation: "mini-slides",
  progress-bar: true,
  badge-label: [ICAICTA 2026],
  font-style: "academic", // "academic" | "cute" | "modern" | "formal"
  font-heading: auto,
  font-body: auto,
  font-code: auto,
  font-accent: auto,
  ..args,
  body,
) = {
  // Extract font configuration if passed via config-fonts()
  let font-config = args.pos().find(item => type(item) == dictionary and "fonts" in item)
  let fonts = if font-config != none {
    font-config.fonts
  } else {
    config-fonts(
      style: font-style,
      heading: font-heading,
      body: font-body,
      code: font-code,
      accent: font-accent,
    ).fonts
  }

  // Update global typography state
  if-fonts-state.update(fonts)

  // Document-wide typographic foundations
  set text(font: fonts.body, size: 19pt, fill: if-text, lang: "en", number-type: "lining")
  set par(justify: false, leading: 0.65em)
  show heading: set text(font: fonts.heading, fill: if-blue-dark)
  show raw: set text(font: fonts.code)

  show: touying-slides.with(
    config-page(
      paper: "presentation-" + aspect-ratio,
      fill: if-bg,
      background: corner-flag(dark: false, size-scale: 1.0),
      margin: (top: 3.1cm, bottom: 1.8cm, x: 1.5cm),
      header: _if-header,
      footer: _if-footer,
      header-ascent: 0.7cm,
      footer-descent: 0em,
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: section-slide,
    ),
    config-colors(
      primary: if-blue,
      secondary: if-blue-dark,
      tertiary: if-gold,
      neutral-darkest: if-text,
      neutral-dark: if-text-muted,
      neutral-lightest: if-bg,
    ),
    config-store(
      navigation: navigation,
      progress-bar: progress-bar,
      badge-label: badge-label,
      current-slide-title: auto,
      current-slide-subtitle: none,
      fonts: fonts,
    ),
    config-methods(
      init: (self: none, body) => {
        let f = if self != none and "fonts" in self.store { self.store.fonts } else { fonts }
        set text(font: f.body, size: 19pt, fill: if-text, lang: "en", number-type: "lining")
        set par(justify: false, leading: 0.65em)
        show heading: set text(font: f.heading, fill: if-blue-dark)
        show raw: set text(font: f.code)

        // Bullet styling with ITS blue & gold geometric markers
        set list(
          marker: (
            text(fill: if-blue, size: 0.75em)[◆],
            text(fill: if-gold, size: 0.65em)[■],
            text(fill: if-slate-dark, size: 0.6em)[•],
          ),
          spacing: 0.45em,
          body-indent: 0.6em,
        )

        // Numbered list styling with cute rounded pills
        set enum(
          numbering: n => box(
            fill: if-blue,
            radius: 100pt,
            inset: (x: 0.45em, y: 0.15em),
            text(font: f.accent, fill: white, size: 0.75em, weight: "bold")[#n]
          ),
          spacing: 0.45em,
          body-indent: 0.6em,
        )

        // Codly code block initialization
        show: codly-init.with()
        codly(
          stroke: 1pt + if-border,
          radius: 5pt,
          fill: if-surface-tint,
          zebra-fill: if-blue-pale,
          display-name: false,
          display-icon: false,
          number-format: n => text(font: f.code, fill: if-slate-dark, size: 0.75em)[#n],
        )

        // Links and emphasis
        show link: set text(fill: if-blue)
        show emph: it => text(fill: if-blue-dark, style: "italic", it.body)
        show strong: it => text(fill: if-blue-dark, weight: "bold", it.body)

        body
      },
    ),
    ..args,
  )

  body
}

/// Alias for conference convenience
#let icaicta-theme = if-theme
