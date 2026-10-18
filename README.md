# ITS Teknik Informatika Presentation Template for Typst

A clean, modern, and cute slide deck template crafted for **ITS Teknik Informatika** paper presentations, academic conferences (such as **ICAICTA 2026**), defense seminars, and lectures — powered by [Touying](https://github.com/touying-typ/touying) and styled after the official `IF PPT Template.pptx`.

## ✨ Features

- **Official ITS & IF Identity**:
  - ITS Cyan-Blue (`#0F7BC1`), Deep Navy (`#0E2841`), ITS Gold/Yellow (`#FCB914`), and Deep Blue (`#107BC2`).
  - Top-left signature ITS IF dual-notch corner flag on all slides.
  - Menara Sains ITS building vector illustration and ITS Batik motifs.
  - High-res vector and transparent PNG logos for Departemen Teknik Informatika & Institut Teknologi Sepuluh Nopember.
- **Academic & Oral Presentation Components**:
  - `#paper-meta`: Conference header card displaying track, paper ID, and oral session.
  - `#research-question` / `#rq-box`: Highlight box for research questions (RQ1, RQ2).
  - `#stat-card` / `#metric-card`: Large metric cards for benchmark results ($F_1$-score, latency, speedup, parameter savings).
  - `#cblock`: Semantic callout boxes (`method`, `result`, `challenge`, `problem`, `info`, `tip`, `warning`, `gold`, `cute`).
  - `#quote-block`: Clean left-bordered quote callout (with `#it-quote` preset).
  - `#step`: Numbered pipeline / methodology walkthrough items.
  - `#split`: Multi-column responsive layout helper.
  - `#note`: Speaker notes integrated with `pdfpc` for oral presentation scripts.
- **Slide Layouts**:
  - `#title-slide`: Cover slide supporting `"white"`, `"blue"`, or `"dark"` variants, metadata pills, and Menara Sains artwork.
  - `#outline-slide`: Automated presentation roadmap.
  - `#section-slide`: Module dividers with large section number pills and watermark tower.
  - `#comparison-slide`: Side-by-side comparison for baselines vs proposed methods.
  - `#focus-slide`: High-contrast dark navy standout slide for key takeaways.
  - `#thank-you-slide`: Closing & Q&A slide with contact details, repo links, and quote.
  - `#blank-slide`: Canvas for full-bleed architecture diagrams or live demos.
- **Multi-Role Typography Presets**:
  - `font-style: "academic"` (default: Segoe UI + Calibri + Cascadia Code)
  - `font-style: "cute"` (Century Gothic + Corbel + Cascadia Code)
  - `font-style: "modern"` (Bahnschrift + Segoe UI)
  - `font-style: "formal"` (Cambria + Calibri)

## 🚀 Quickstart

Create or open `slides.typ`:

```typ
#import "@local/if-presentation:0.1.0": *

#show: if-theme.with(
  aspect-ratio: "16-9",
  progress-bar: true,
  badge-label: [ICAICTA 2026],
  font-style: "academic", // "academic" | "cute" | "modern" | "formal"
  config-info(
    title: [Your Paper Title Goes Here],
    subtitle: [Oral Presentation · Paper ID #128],
    author: [Your Name & Co-Author],
    institution: [Departemen Teknik Informatika, Institut Teknologi Sepuluh Nopember],
    date: [October 21, 2026],
  ),
)

// --- Cover Slide ---
#title-slide(
  conference: [ICAICTA 2026],
  paper-id: "128",
  session: [Oral Session: AI & Vision],
  tags: ([Edge AI], [Vision Transformer]),
  tag-style: "kicker", // "line" | "kicker" | "subtle" | "pill" | "none"
  variant: "white", // or "blue" / "dark"
)

// --- Presentation Roadmap ---
#outline-slide()

= Motivation & Background

== Problem Formulation

Write your slide content with clean bullets:

- *First point*: Key observation from preliminary experiments.
- *Second point*: Limitations of existing baseline approaches.

#v(0.4em)

#split[
  #stat-card("3.8x", "Speedup", subtext: [Over unpruned baseline], color: if-blue)
][
  #stat-card("< 15ms", "Latency", subtext: [On Jetson Orin Nano], color: if-gold-dark)
][
  #stat-card("-71%", "RAM Usage", subtext: [Peak runtime allocation], color: rgb("#16A34A"))
]

#note("Don't forget to highlight the 15ms edge latency constraint during the talk!")
```

## 🔨 Compile & Watch

```bash
# Compile once to PDF
typst compile slides.typ output.pdf

# Live-reload watch mode during editing
typst watch slides.typ output.pdf
```

## 📦 Local Installation

The package is linked locally to:
- `@local/if-presentation:0.1.0`
- `@local/icaicta-presentation:0.1.0`

You can also scaffold a new deck anywhere using:

```bash
typst init @local/if-presentation:0.1.0 my-presentation
```
