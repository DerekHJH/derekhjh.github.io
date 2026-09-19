# AGENTS.md

Rules every agent working in this repository MUST follow. These are hard
requirements, not suggestions.

This is Junhao Hu's academic personal website (Academic Pages / Jekyll). The
same information (publications, projects, experience, awards, services) lives in
**two** places that must never drift apart: the website content and the LaTeX
CV.

## 1. Keep the CV and the website in sync

Any change to content (e.g. adding/moving/renaming a publication, updating
experience, awards, services) MUST be applied to **both**:

- **Website**: the relevant file under `_pages/` (e.g. publications go in
  `_pages/publications.md`).
- **CV source**: the matching LaTeX file under `_cv_src/` (e.g. publications go
  in `_cv_src/sections/publication.tex`).

Never update one and leave the other stale.

## 2. Always recompile the CV and place the PDF

After editing any `_cv_src/**` file, you MUST recompile and publish the PDF:

```bash
cd _cv_src
pdflatex -interaction=nonstopmode -halt-on-error main.tex   # run twice for refs
/bin/cp -f main.pdf ../files/cv.pdf
```

- Run `pdflatex` **twice** so cross-references/pages resolve.
- The published PDF served by the site is `files/cv.pdf` — the build output
  `_cv_src/main.pdf` must be copied there.
- Use `/bin/cp -f` (or `\cp -f`); plain `cp` is aliased to interactive mode and
  will silently fail to overwrite.
- Verify the change landed, e.g.
  `pdftotext files/cv.pdf - | grep <keyword>`.

## 3. Never commit or push without explicit confirmation

Do NOT run `git commit` or `git push` until Junhao (the repo owner) has
personally reviewed the changes and confirmed. Make the edits, report what was
done, and wait for his go-ahead. This applies even when the work looks complete.
