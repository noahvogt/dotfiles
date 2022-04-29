" disable netrw.
let g:loaded_netrw  = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1

augroup my-fern-hijack
  autocmd!
  autocmd BufEnter * ++nested call s:hijack_directory()
augroup END

function! s:hijack_directory() abort
  let path = expand('%:p')
  if !isdirectory(path)
    return
  endif
  bwipeout %
  execute printf('Fern %s', fnameescape(path))
endfunction

augroup FernGroup
  autocmd!
  autocmd FileType fern call FernInit()
augroup END

" custom settings and mappings.
let g:fern#disable_default_mappings = 1
let g:fern#disable_drawer_tabpage_isolation = 1
let g:fern#default_hidden = 0
let g:fern#renderer = "nerdfont"

" add dirs and files inside the brackets that need to remain hidden
let hide_dirs  = '^\%(\.git\|node_modules\)$'  " here you write the dir names 
let hide_files = '\%(^.*\.class\|\.ruby-\)\+'    " here you write the file names

let g:fern#default_exclude = hide_dirs . '\|' . hide_files  " here you exclude them
