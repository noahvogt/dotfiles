" fix latex commenting
augroup fixLatexComments
  autocmd!
  autocmd FileType plaintex,tex,latex syntax spell toplevel
augroup END
" Automatically wrap at 80 characters for Markdown
" autocmd BufRead,BufNewFile *.md setlocal textwidth=80

function! MathAndLiquid()
    "" Define certain regions
    " Block math. Look for "$$[anything]$$"
    syn region math start=/\$\$/ end=/\$\$/
    " inline math. Look for "$[not $][anything]$"
    syn match math_block '\$[^$].\{-}\$'

    " Liquid single line. Look for "{%[anything]%}"
    syn match liquid '{%.*%}'
    " Liquid multiline. Look for "{%[anything]%}[anything]{%[anything]%}"
    syn region highlight_block start='{% highlight .*%}' end='{%.*%}'
    " Fenced code blocks, used in GitHub Flavored Markdown (GFM)
    syn region highlight_block start='```' end='```'

    "" Actually highlight those regions.
    hi link math Statement
    hi link liquid Statement
    hi link highlight_block Function
    hi link math_block Function
endfunction

" Call everytime we open a Markdown file
augroup callMathFunction
  autocmd!
  autocmd BufRead,BufNewFile,BufEnter *.md,*.markdown call MathAndLiquid()
augroup END

" active to autocompile docs on saving
"autocmd BufWritePost *.ms !compile % | fold -w200
"autocmd BufWritePost *.tex !compile % | fold -w200

" disable automatic comment
augroup disableAutoComment
  autocmd!
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END

" clear a TeX build after exiting vim
augroup texclear
  autocmd!
  autocmd VimLeavePre *.tex !texclear "%"
  autocmd VimLeavePre *.md !texclear "%"
augroup END

" use python syntax highlighting for .tibasic files
augroup tibasic
  autocmd!
  autocmd BufNewFile,BufRead *.tibasic set filetype=python
  autocmd BufNewFile,BufRead *.tib set filetype=python
augroup END

function! FernInitReload() abort
  augroup FernGroupLocal
    autocmd! * <buffer>
    autocmd BufEnter <buffer> silent execute "normal \<Plug>(fern-action-reload)"
  augroup END
endfunction

augroup OnEnteringFernWindow
  autocmd!
  autocmd FileType fern call FernInitReload()
augroup END

" enable emmet only for html / css files
augroup EmmetEnabler
  autocmd!
  autocmd FileType html,css EmmetInstall
augroup END

" colored nerdfont icons on fern + startify buffers
augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType startify call glyph_palette#apply()
augroup END

" relative line numbers
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
