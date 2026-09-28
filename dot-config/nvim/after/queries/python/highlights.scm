; extends

; Markdown cells of Jupyter notebooks (see lua/jupyter.lua): normal text
; instead of comment style, the injected markdown highlights go on top
((comment) @jupyter.markdown
  (#jupyter-markdown-cell? @jupyter.markdown))
