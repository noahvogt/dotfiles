" set custom welcome message header
let g:startify_custom_header = [
        \ '   _   ___     ___',
        \ '   | \ | \ \   / (_)_ __ ___',
        \ '   |  \| |\ \ / /| | |_ ` _ \',
        \ '   | |\  | \ V / | | | | | | |',
        \ '   |_| \_|  \_/  |_|_| |_| |_|',
        \]

" auto restart session
" NOTE: If this option is enabled and you start Vim in a directory that contains a
" Session.vim, that session will be loaded automatically. Otherwise it will be
" shown as the top entry in the Startify buffer.
let g:startify_session_autoload = 1

" let startify take care of buffers
let g:startify_session_delete_buffers = 1

" similar to vim-rooter
let g:startify_change_to_vcs_root = 1

" use unicode
let g:startify_fortune_use_unicode = 1

" auto update sessions
let g:startify_session_persistence = 1

" get rid of empy buffer and quit
let g:startify_enable_special = 0

let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Files']            },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ ]
