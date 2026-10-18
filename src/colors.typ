/// ITS Teknik Informatika Color Palette
/// Derived from official ITS guidelines and `IF PPT Template.pptx`

// Brand Colors
#let if-blue = rgb("#0F7BC1")          // Vibrant ITS Blue / Cyan-Blue
#let if-blue-dark = rgb("#0E2841")     // Deep Navy Blue (PPT Theme dk2)
#let if-blue-deep = rgb("#107BC2")     // PPT Slide Background Blue
#let if-blue-navy = rgb("#091B2E")     // Midnight Navy for high-contrast slides
#let if-blue-subtle = rgb("#0E7AC0")   // PPT Mid-tone Blue
#let if-blue-light = rgb("#E8F3FA")    // Soft Blue Tint for cards / pills
#let if-blue-pale = rgb("#F0F7FC")     // Ultra-light Blue Tint for backgrounds

#let if-gold = rgb("#FCB914")          // Signature ITS Yellow / Gold
#let if-gold-dark = rgb("#D99805")     // Amber Gold for text contrast
#let if-gold-light = rgb("#FEF6DD")    // Light Gold for pills / callouts
#let if-orange = rgb("#E97132")        // PPT Accent 2

// Neutral Foundation
#let if-bg = rgb("#FFFFFF")            // Crisp White Slide Canvas
#let if-bg-soft = rgb("#F8FAFC")       // Soft Off-White / Slate Tint
#let if-surface = rgb("#FFFFFF")       // Card Surface
#let if-surface-tint = rgb("#F1F5F9")  // Muted Card Surface
#let if-border = rgb("#E2E8F0")        // Card / Container Border
#let if-slate = rgb("#94A3B8")         // Muted Slate
#let if-slate-light = rgb("#F1F5F9")   // Pill / Tag Background
#let if-slate-dark = rgb("#475569")    // Secondary Text

// Typography Colors
#let if-text = rgb("#0E2841")          // Primary Dark Navy Body & Headings
#let if-text-muted = rgb("#556980")    // Secondary / Caption Text
#let if-text-light = rgb("#94A3B8")    // Footer & Tagline Muted Text

// Semantic Callout Themes for Paper Presentations & Seminars
#let if-semantic = (
  info: (
    primary: rgb("#0F7BC1"),
    bg: rgb("#F0F7FC"),
    border: rgb("#BAE6FD"),
    text: rgb("#0369A1"),
  ),
  method: (
    primary: rgb("#4F46E5"),
    bg: rgb("#EEF2FF"),
    border: rgb("#C7D2FE"),
    text: rgb("#3730A3"),
  ),
  result: (
    primary: rgb("#16A34A"),
    bg: rgb("#F0FDF4"),
    border: rgb("#BBF7D0"),
    text: rgb("#15803D"),
  ),
  challenge: (
    primary: rgb("#D97706"),
    bg: rgb("#FFFBEB"),
    border: rgb("#FDE68A"),
    text: rgb("#B45309"),
  ),
  problem: (
    primary: rgb("#DC2626"),
    bg: rgb("#FEF2F2"),
    border: rgb("#FECACA"),
    text: rgb("#B91C1C"),
  ),
  warning: (
    primary: rgb("#D97706"),
    bg: rgb("#FFFBEB"),
    border: rgb("#FDE68A"),
    text: rgb("#B45309"),
  ),
  danger: (
    primary: rgb("#DC2626"),
    bg: rgb("#FEF2F2"),
    border: rgb("#FECACA"),
    text: rgb("#B91C1C"),
  ),
  tip: (
    primary: rgb("#0D9488"),
    bg: rgb("#F0FDFA"),
    border: rgb("#99F6E4"),
    text: rgb("#0F766E"),
  ),
  gold: (
    primary: rgb("#D99805"),
    bg: rgb("#FEF9C3"),
    border: rgb("#FDE047"),
    text: rgb("#A16207"),
  ),
  cute: (
    primary: rgb("#8B5CF6"),
    bg: rgb("#F5F3FF"),
    border: rgb("#DDD6FE"),
    text: rgb("#6D28D9"),
  ),
)
