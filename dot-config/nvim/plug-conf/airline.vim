" enable tabline
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#left_sep = ''
" let g:airline#extensions#tabline#left_alt_sep = ''
" let g:airline#extensions#tabline#right_sep = ''
" let g:airline#extensions#tabline#right_alt_sep = ''
call airline#parts#define_function(
   \ 'gradle-running',
   \ 'lightline#gradle#running'
   \)

" enable powerline fonts
let g:airline_powerline_fonts = 1
let g:airline#extensions#wordcount#enabled = 1
let g:airline_section_x = airline#section#create_right([
   \ 'filetype',
   \ 'gradle-running'
   \])
