# Figures

Typst sources for figures used in the CV and on the website. Fonts are vendored
in `fonts/` (Inter, OFL) so builds look the same on any machine.

```bash
cd typst
typst compile --font-path fonts research-map.typ ../_cv_src/figures/research-map.pdf
typst compile --font-path fonts research-map.typ ../images/research-map.svg
```

After rebuilding the PDF, recompile the CV (see `AGENTS.md`).
