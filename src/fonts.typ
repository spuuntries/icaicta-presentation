/// Font configuration for ITS Teknik Informatika Presentation Template
///
/// Provides coordinated typography presets across 4 roles:
/// - `heading`: Slide titles, section dividers, card headers
/// - `body`: Text paragraphs, lists, explanations
/// - `code`: Monospace syntax highlighting, inline code
/// - `accent`: Badges, pills, slide numbers, metric values

#let default-font-presets = (
  academic: (
    heading: ("Segoe UI", "Arial", "Calibri"),
    body: ("Segoe UI", "Calibri", "Arial"),
    code: ("Cascadia Code", "Consolas", "Courier New"),
    accent: ("Segoe UI", "Arial"),
  ),
  cute: (
    heading: ("Century Gothic", "Segoe UI", "Arial"),
    body: ("Corbel", "Segoe UI", "Arial"),
    code: ("Cascadia Code", "Consolas"),
    accent: ("Century Gothic", "Segoe UI", "Arial"),
  ),
  modern: (
    heading: ("Bahnschrift", "Segoe UI", "Arial"),
    body: ("Segoe UI", "Arial"),
    code: ("Cascadia Code", "Consolas"),
    accent: ("Bahnschrift", "Segoe UI"),
  ),
  formal: (
    heading: ("Cambria", "Times New Roman", "Segoe UI"),
    body: ("Calibri", "Segoe UI", "Arial"),
    code: ("Cascadia Code", "Consolas"),
    accent: ("Cambria", "Segoe UI"),
  ),
)

/// Configure presentation fonts with presets or custom families
#let config-fonts(
  style: "academic",
  body: auto,
  heading: auto,
  code: auto,
  accent: auto,
) = {
  let base = default-font-presets.at(style, default: default-font-presets.academic)
  (
    fonts: (
      heading: if heading != auto { heading } else { base.heading },
      body: if body != auto { body } else { base.body },
      code: if code != auto { code } else { base.code },
      accent: if accent != auto { accent } else { base.accent },
    )
  )
}

/// Global state storing the active typography configuration
#let if-fonts-state = state("if-fonts", default-font-presets.academic)
