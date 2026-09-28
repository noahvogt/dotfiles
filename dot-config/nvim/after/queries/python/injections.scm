; extends

; Markdown cells of Jupyter notebooks (py:percent, see lua/jupyter.lua):
; highlight each "# text" comment line as markdown
((comment) @injection.content
  (#lua-match? @injection.content "^# ")
  (#jupyter-markdown-cell? @injection.content)
  (#offset! @injection.content 0 2 0 0)
  (#set! injection.language "markdown"))
