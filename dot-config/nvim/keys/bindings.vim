let mapleader = " "

" move text buffer in visual mode
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv

" write and quit easier
nnoremap <Leader>w :w<CR>
nnoremap <Leader>z :wq<CR>
nnoremap <Leader>q :qa<CR>
nnoremap <Leader>e :q<CR>

" windows commands
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <leader>ps :Rg<CR>
nnoremap <leader>rh :vertical resize +5<CR>
nnoremap <leader>rl :vertical resize -5<CR>

" general custom commands
command D filetype detect

" commands for opening and compiling various document types
command S silent !vshow '%:p'
command C !compile "%"

" general compile button
map <F3> :w<CR>:!compile "%" && pkill -HUP mupdf<CR>

" bibtex extra compiler
map <F2> :w<CR>:!latexmk -pdf "%" && pkill -HUP mupdf<CR>

map <F4> :noh<CR>
map <F5> :set spell!<CR>
map <F6> :w<CR>:!glosscompile "%" && pkill -HUP mupdf<CR>

" jumper
vnoremap <Space><Space> <Esc>/<++><Enter>"_c4l
map <Space><Space> <Esc>/<++><Enter>"_c4l

"copy from / to clipboard
vnoremap <leader>y "+y
vnoremap <leader>Y "+Y
nmap <leader>p "+p
nmap <leader>P "+P

" Use `[g` and `]g` to navigate diagnostics
nnoremap <silent> [g <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> ]g <cmd>lua vim.diagnostic.goto_next()<CR>

" Use <leader>d to manually open diagnostic popup
nnoremap <leader>d <cmd>lua vim.diagnostic.open_float()<CR>

" Remap keys for gotos
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gy <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>

nnoremap <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>

" switch (back and forth) to (and from) the last opened file
nmap <leader>b <c-^><cr>

noremap <silent> <Leader>f :Fern . -drawer -reveal=% -toggle -width=35<CR><C-w>=

function! FernInit() abort
  nmap <buffer><expr>
        \ <Plug>(fern-my-open-expand-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:select)",
        \   "\<Plug>(fern-action-expand:stay)",
        \   "\<Plug>(fern-action-collapse)",
        \ )
  nmap <buffer> <CR> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> <2-LeftMouse> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> n <Plug>(fern-action-new-path)
  nmap <buffer> d <Plug>(fern-action-remove)
  nmap <buffer> m <Plug>(fern-action-move)
  nmap <buffer> M <Plug>(fern-action-rename)
  nmap <buffer> c <Plug>(fern-action-hidden:toggle)
  nmap <buffer> r <Plug>(fern-action-reload)
  nmap <buffer> g <Plug>(fern-action-mark:toggle)
  nmap <buffer> o <Plug>(fern-action-open)
  nmap <buffer> b <Plug>(fern-action-open:split)
  nmap <buffer> v <Plug>(fern-action-open:vsplit)
  nmap <buffer> h <Plug>(fern-action-collapse)
  nmap <buffer> l <Plug>(fern-action-expand:stay)
  nmap <silent> <buffer> p     <Plug>(fern-action-preview:toggle)
  nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
  nmap <silent> <buffer> <C-d> <Plug>(fern-action-preview:scroll:down:half)
  nmap <silent> <buffer> <C-u> <Plug>(fern-action-preview:scroll:up:half)
  nmap <buffer><nowait> < <Plug>(fern-action-leave)
  nmap <buffer><nowait> > <Plug>(fern-action-enter)
endfunction

" Use `:Format` to format current buffer
command! -nargs=0 Format :lua require("conform").format()
cabbrev Black Format

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" auto center view when walking through searches
nnoremap n nzzzv
nnoremap N Nzzzv

" toggle tag bar
nmap <leader>g :TagbarToggle<CR>

" please write
cmap w!! w !doas tee %

function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction

" smart global buffor / window switching
nnoremap <silent> <C-h> :call WinMove('h')<CR>
nnoremap <silent> <C-j> :call WinMove('j')<CR>
nnoremap <silent> <C-k> :call WinMove('k')<CR>
nnoremap <silent> <C-l> :call WinMove('l')<CR>

" source vim config
nnoremap <Leader>sv :source $XDG_CONFIG_HOME/nvim/init.vim<CR>

nnoremap <leader>l :Telescope live_grep<CR>
nnoremap <leader>t :Telescope git_files<CR>
nnoremap <leader>z :Telescope find_files<CR>
nnoremap <C-s> :Telescope grep_string<CR>

" markdown preview mappings
nmap <leader>mg <Plug>MarkdownPreview
nmap <leader>ms <Plug>MarkdownPreviewStop
nmap <leader>mt <Plug>MarkdownPreviewToggle

" correct whitespace
nnoremap <leader>cw :StripWhitespace<CR>

" move to next / previous trailing whitespace
nnoremap ]w :NextTrailingWhitespace<CR>
nnoremap [w :PrevTrailingWhitespace<CR>

" spell jump
nnoremap ]s ]s
nnoremap [s [s

nnoremap <leader>da :call vimspector#Launch()<CR>
nnoremap <leader>dc :call GotoWindow(g:vimspector_session_windows.code)<CR>
nnoremap <leader>dv :call GotoWindow(g:vimspector_session_windows.variables)<CR>
nnoremap <leader>dw :call vimspector#ClearBreakpoints()<CR>
nnoremap <leader>ds :call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>
nnoremap <leader>do :call GotoWindow(g:vimspector_session_windows.output)<CR>
nnoremap <leader>di :call AddToWatch()<CR>
nnoremap <leader>dx :call vimspector#Reset()<CR>
nnoremap <leader>dX :call vimspector#ClearBreakpoints()<CR>
nnoremap <S-k> :call vimspector#StepOut()<CR>
nnoremap <S-l> :call vimspector#StepInto()<CR>
nnoremap <S-j> :call vimspector#StepOver()<CR>
nnoremap <leader>d_ :call vimspector#Restart()<CR>
nnoremap <leader>dn :call vimspector#Continue()<CR>
nnoremap <leader>drc :call vimspector#RunToCursor()<CR>
nnoremap <leader>dh :call vimspector#ToggleBreakpoint()<CR>
nnoremap <leader>de :call vimspector#ToggleConditionalBreakpoint()<CR>
