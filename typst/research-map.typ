// Research map shown in the CV and on the homepage.
// Build: see typst/README.md.

#let W = 17cm
#let H = 8cm
#set page(width: W, height: H, margin: 0pt, fill: white)
#set text(font: "Inter", size: 8pt, fill: rgb("#1F2430"))

#let axis-ink = rgb("#3A4150")

// Hue encodes the horizontal axis; saturation encodes the vertical one.
#let blue = (accent: rgb("#2F6BD8"), soft: rgb("#EEF3FC"), strong: rgb("#E2EBFA"), edge: rgb("#CBD9F3"))
#let violet = (accent: rgb("#6A4BD6"), soft: rgb("#F2EFFC"), strong: rgb("#E8E2FA"), edge: rgb("#D7CEF5"))

// Side margins hold the horizontal axis labels; top and bottom hold the vertical ones.
#let x0 = 3cm
#let x1 = W - 3cm
#let y0 = 0.75cm
#let y1 = H - 0.75cm
#let gap = 0.6cm
#let qw = (x1 - x0 - gap) / 2
#let qh = (y1 - y0 - gap) / 2
#let xm = (x0 + x1) / 2
#let ym = (y0 + y1) / 2

#let chip(name, c) = box(
  fill: white, stroke: 0.5pt + c.edge, radius: 99pt,
  inset: (x: 5pt, y: 3pt),
  text(weight: "medium", size: 7.4pt)[
    #box(baseline: -0.5pt, circle(radius: 2.3pt, fill: c.accent)) #h(2.5pt) #name
  ],
)

#let badge(label, c, future: false) = box(
  fill: if future { white } else { c.accent },
  stroke: if future { 0.6pt + c.accent } else { none },
  radius: 99pt, inset: (x: 5pt, y: 2.4pt),
  text(size: 6.2pt, weight: "bold", tracking: 0.8pt, fill: if future { c.accent } else { white })[#label],
)

#let quadrant(x, y, c, chips: (), tag: none, future: false) = place(
  top + left, dx: x, dy: y,
  block(
    width: qw, height: qh, radius: 9pt, inset: 10pt,
    fill: if future { white } else if y < ym { c.strong } else { c.soft },
    stroke: if future { (paint: c.edge, thickness: 0.9pt, dash: (3pt, 2.2pt)) } else { 0.6pt + c.edge },
  )[
    #if tag != none { place(top + right, badge(tag, c, future: future)) }
    #align(center + horizon, block(width: 100%)[
      #set par(leading: 5pt)
      #chips.map(n => chip(n, c)).join(h(3pt))
    ])
  ],
)

// Arrows sit on the axes to mark the order of the journey.
#let hop(x, y, glyph, c, future: false) = place(
  top + left, dx: x - 8pt, dy: y - 8pt,
  circle(
    radius: 8pt, fill: white,
    stroke: if future { (paint: c.accent, thickness: 0.7pt, dash: (1.6pt, 1.2pt)) } else { 0.7pt + c.accent },
  )[#set align(center + horizon); #text(size: 9pt, weight: "bold", fill: c.accent)[#glyph]],
)

#quadrant(x0, ym + gap / 2, blue,
  chips: ("EPIC", "DeepServe", "RedKnot", "RaaS", "Lil", "Hy4", "MiMo-V2"))
#quadrant(xm + gap / 2, ym + gap / 2, violet,
  chips: ("PenguinHarness", "Hunyuan Harness", "Akashic"))
#quadrant(xm + gap / 2, y0, violet,
  chips: ("GDPevo", "Awesome-RSI", "Hunyuan RSI"), tag: "NOW")
#quadrant(x0, y0, blue, tag: "NEXT", future: true)

// Axes: double-headed, extending slightly past the quadrants.
#let ext = 0.3cm
#let head = 4pt
#let tip(x, y, ux, uy) = place(top + left, polygon(fill: axis-ink,
  (x, y),
  (x - ux * head * 1.6 - uy * head * 0.7, y - uy * head * 1.6 + ux * head * 0.7),
  (x - ux * head * 1.6 + uy * head * 0.7, y - uy * head * 1.6 - ux * head * 0.7)))
#place(top + left, line(start: (x0 - ext, ym), end: (x1 + ext, ym), stroke: 0.8pt + axis-ink))
#place(top + left, line(start: (xm, y0 - ext), end: (xm, y1 + ext), stroke: 0.8pt + axis-ink))
#tip(x1 + ext, ym, 1, 0)
#tip(x0 - ext, ym, -1, 0)
#tip(xm, y0 - ext, 0, -1)
#tip(xm, y1 + ext, 0, 1)

#hop(xm, ym + gap / 2 + qh / 2, sym.arrow.r, blue)
#hop(xm + gap / 2 + qw / 2, ym, sym.arrow.t, violet)
#hop(xm, y0 + qh / 2, sym.arrow.l, blue, future: true)

#let label(body) = text(size: 9pt, weight: "semibold", fill: axis-ink)[#body]
#place(top + left, dx: 0cm, dy: ym - 0.5cm,
  box(width: x0 - ext - 0.2cm, height: 1cm, align(right + horizon, label[Inference Infra])))
#place(top + left, dx: x1 + ext + 0.2cm, dy: ym - 0.5cm,
  box(width: W - x1 - ext - 0.2cm, height: 1cm, align(left + horizon, label[Agent Infra])))
#place(top + left, dx: xm - 2cm, dy: 0cm,
  box(width: 4cm, height: y0 - ext - 0.05cm, align(center + horizon, label[AI4Infra])))
#place(top + left, dx: xm - 2cm, dy: y1 + ext + 0.05cm,
  box(width: 4cm, height: H - y1 - ext - 0.05cm, align(center + horizon, label[Infra4AI])))
