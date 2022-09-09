" standard macros
autocmd FileType tex inoremap ;beg <Esc>yypkI\begin{<Esc>A}<Esc>o<Esc>0i<Esc>jI\end{<Esc>A}<CR><Esc>0i<CR><Esc>0i<++><Esc>3ki
autocmd FileType tex inoremap ;ig \includegraphics[]{<++>}<Esc>6hi
autocmd FileType tex inoremap ;tw width=\textwidth<Esc>9hi
autocmd FileType tex inoremap ;th height=\textheight<Esc>10hi
autocmd FileType tex inoremap ;ni \setlength{\parindent}{0em}<Esc>

" packages
autocmd FileType tex inoremap ;ger \usepackage[ngerman]{babel}<Esc>

" text formatting macros
autocmd FileType tex inoremap ;bf \textbf{}<++><Esc>T{i
autocmd FileType tex inoremap ;it \textit{}<++><Esc>T{i
autocmd FileType tex inoremap ;tt \texttt{}<++><Esc>T{i

" beamer macros
autocmd FileType tex inoremap ;fr \begin{frame}<CR>\frametitle{}<CR><++><CR>\end{frame}<Esc>kklli

" book macros
autocmd FileType tex inoremap ;sw \switchcolumn[]<++><Esc>4hi

" preambule macros
autocmd FileType tex inoremap ;up \usepackage{}<Esc>i
autocmd FileType tex inoremap ;hy \hyphenation{}<Esc>i

autocmd FileType tex inoremap ;s1 \section{}<Esc>i
autocmd FileType tex inoremap ;s2 \subsection{}<Esc>i
autocmd FileType tex inoremap ;s3 \subsubsection{}<Esc>i

" apacite style
autocmd FileType tex inoremap ;ap \bibliographystyle{apacite}<CR>\bibliography{}<Esc>i
