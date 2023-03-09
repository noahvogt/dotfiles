" change trailing whitespace color
let g:better_whitespace_ctermcolor='166'

" autostrip on save
let g:strip_whitespace_on_save=1

" disable by default
let g:better_whitespace_enabled=0

" soft (instead of hard) disable warning on current line
let g:current_line_whitespace_disabled_soft=1

" disable confirmation prompt
let g:strip_whitespace_confirm=0

" blacklisted filetypes
let g:better_whitespace_filetypes_blacklist=['diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'markdown', 'fugitive']
