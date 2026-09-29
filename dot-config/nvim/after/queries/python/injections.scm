; extends

; Markdown cells of Jupyter notebooks (py:percent, see lua/jupyter.lua): all
; "# text" lines form one markdown document, so multi-line constructs like
; $$ blocks parse (the range skips the "# " prefix and includes the newline)
((comment) @injection.content
  (#jupyter-markdown-cell? @injection.content)
  (#jupyter-markdown-range! @injection.content)
  (#set! injection.language "markdown")
  (#set! injection.combined))
