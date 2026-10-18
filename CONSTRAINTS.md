# THE TERMINAL — Constraints & Ground Rules

The non-negotiable constraints that shaped Issue 01. Any new contributor / next issue editor: read this first.

## 1. Data policy (hard constraint)

- **Verbatim data only.** Every name, score, date, title and number must come exactly as written from `sources/Source.txt` / `sources/Source.pdf` (official dept. semester deck). No invented sticker stats, no invented ranks.
- `content_plan.md` is the **authoritative fact sheet** — anything in the HTML must trace back to it or the source.
- **Date window: 01 Jan 2026 – 30 Jun 2026 only.** Events outside the window are excluded (e.g. Dec-2025 and 2025-edition events were dropped from the final build).

## 2. Structure

- Exactly **5 pages**, A4, print-first (margins zero, everything sized in mm). Page 5 = S4 Toppers honors board (25 faces cropped from the dept-supplied graphic, rebuilt in template style).
- p1 Cover + Principal & HoD letters · p2 Events + PEO/PSO + stats strip · p3 Semester stories + CTEP/CLAD/awards · p4 YIP/individual wins + MoU + roadmap + Editorial Board + closer band.

## 3. Design system

- Fonts: **Inter, JetBrains Mono, Merriweather, Space Grotesk** — all OFL licensed (`fonts/`), embedded locally, no CDN.
- Chroma card system: 7 mood hues (indigo/teal/amber/rose/violet/olive/sky), solid pre-blended tints — never rgba alpha over another fill (WeasyPrint double-paints alpha).
- Tilt classes `.tilt-l2/.tilt-r2/.tilt-l3/.tilt-r3` for the hand-placed look; keep alternate direction across neighbors.
- No generic template labels anywhere (originally "COMMON TEMPLATE · ACCREDITATION SERIES" wording was scrubbed).

## 4. Build constraints (WeasyPrint v70 lessons)

- Absolutely-positioned `.content` container: **content must fit** — overflowing in-flow rows silently vanish onto a phantom page fragment (hidden under next page's opaque background). Verify with pixel checks, not just silent renders.
- Flex cards stretch to column height — pin photos with `align-self:flex-start`.
- Avoid transforms/nested two-cols in story cards; prefer `.stack .story + .story { margin-top }`.
- Page height 296.8mm vs `@page` 297mm phantom-page rule — keep the 0.2mm gap.
- Render check: `bash build.sh` (WeasyPrint + pypdfium2 contact sheet). Pixel-verify each page's signature regions before shipping.

## 5. Tooling quirks encountered

- `pypdfium2` + Pillow for contact sheets (deprecation warnings ignorable).
- WeasyPrint emits HarfBuzz noise on stderr — filter `grep -v HarfBuzz`.
- No root in the container: system libs extracted from `apt-get download` .debs when needed (see playwright headless setup).

## 6. Uploading / distribution

- GitHub repo is source of truth (public: github.com/tirforge/the-terminal-newsletter).
- gofile.io for one-off PDF sharing: `api.gofile.io/servers` → POST multipart to `https://{server}.gofile.io/contents/uploadfile`.
- Canva conversion in-browser only: drag the PDF into canva.com/upload (API import path unreliable).
