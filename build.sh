#!/usr/bin/env bash
# Regenerate the newsletter PDF from the single source HTML.
# Requires: pip install weasyprint pypdfium2 pillow
set -e
cd "$(dirname "$0")"
python3 -m weasyprint terminal_v3.html output/THE_TERMINAL_v3_Accr.pdf 2>&1 | grep -v HarfBuzz || true
python3 - <<'PY'
import pypdfium2 as pdfium
from PIL import Image
pdf = pdfium.PdfDocument("output/THE_TERMINAL_v3_Accr.pdf")
ims = [p.render(scale=0.75).to_pil() for p in pdf]
w, h = ims[0].size
sheet = Image.new("RGB", (w*2 + 30, h*2 + 30), "#F2F1EC")
for im, xy in zip(ims, [(10,10),(w+20,10),(10,h+20),(w+20,h+20)]):
    sheet.paste(im, xy)
sheet.save("output/preview_v3.png")
print("PDF + contact sheet rebuilt:", len(pdf), "pages")
PY
