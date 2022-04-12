autocmd FileType plaintex,tex,latex syntax spell toplevel
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
autocmd BufRead,BufNewFile,BufEnter *.md,*.markdown call MathAndLiquid()
Plug 'vim-pandoc/vim-pandoc-syntax'
let g:vim_markdown_math = 1

" active to autocompile docs on saving
"autocmd BufWritePost *.ms !compile % | fold -w200
"autocmd BufWritePost *.tex !compile % | fold -w200

" disable automatic comment
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" clear a TeX build after exiting vim
autocmd VimLeavePre *.tex !texclear "%"
autocmd VimLeavePre *.md !texclear "%"
autocmd VimLeavePre *.c !rm -rf .ccls-cache
autocmd VimLeavePre *.cc !rm -rf .ccls-cache
autocmd VimLeavePre *.cpp !rm -rf .ccls-cache
autocmd VimLeavePre *.h !rm -rf .ccls-cache
autocmd VimLeavePre *.hh !rm -rf .ccls-cache

" use python syntax highlighting for .tibasic files
autocmd BufNewFile,BufRead *.tibasic set filetype=python
autocmd BufNewFile,BufRead *.tib set filetype=python
