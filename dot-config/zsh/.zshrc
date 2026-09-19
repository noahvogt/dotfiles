# Enable colors and change prompt:
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
# Personal completions must be on fpath BEFORE compinit runs. A second compinit
# later in this file will NOT rebind a completer already loaded from /usr/share,
# so anything added after this point is silently ignored.
fpath=("$HOME/.local/share/zsh/site-functions" $fpath)
compinit
_comp_options+=(globdots)		# Include hidden files.

# --- just: complete recipes only --------------------------------------------
# just's packaged completer delegates to clap's dynamic completer, which offers
# recipes, every flag and every file through one untagged _describe. Complete
# recipes only, and hand flags / option-arguments back to the upstream one.
_just_upstream() {
    if (( ! $+functions[_clap_dynamic_completer_just] )); then
        source <(JUST_COMPLETE=zsh just) 2>/dev/null
        # That script's last line is
        #   compdef _clap_dynamic_completer_just just
        # which hijacks the `just` binding for the rest of the session. Without
        # undoing it, a single `just --<TAB>` permanently disables this
        # completer until a new shell is opened.
        compdef _just just
    fi
    (( $+functions[_clap_dynamic_completer_just] )) || return 1
    _clap_dynamic_completer_just "$@"
}

_just() {
    local -a recipes lines
    local line name doc

    # Flags themselves, and option arguments such as `--justfile <TAB>`.
    if [[ ${words[CURRENT]} == -* || ${words[CURRENT-1]} == -* ]]; then
        _just_upstream "$@"
        return
    fi

    lines=(${(f)"$(just --list --list-heading '' --list-prefix '' 2>/dev/null)"})

    for line in $lines; do
        [[ -n $line ]] || continue
        # `name ARG1 ARG2   # doc comment` -> name, doc comment
        name=${line%%[[:space:]]*}
        if [[ $line == *'# '* ]]; then
            doc=${line#*'# '}
        else
            doc=''
        fi
        recipes+=( "${name}:${doc}" )
    done

    (( ${#recipes} )) || return 1

    # just runs several recipes in one invocation, so offer them at every word.
    _describe -t recipes 'just recipe' recipes
}

compdef _just just

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-p
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^p' 'lfcd\n'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/exportrc" ] && source "$HOME/.config/exportrc"
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"
[ -f "$HOME/.config/norisa.local" ] && source "$HOME/.config/norisa.local"

if echo $USER | grep -q "miner"; then
    if cat /tmp/norisa/currently-mining | grep -q "0"; then
        echo "Start mining ..."
        echo "1" > /tmp/norisa/currently-mining
        nmine start
    fi
fi

# This is the list for lf icons:
export LF_ICONS="di=📁:\
fi=📃:\
tw=🤝:\
ow=📂:\
ln=⛓:\
or=❌:\
ex=🎯:\
*.txt=✍:\
*.mom=✍:\
*.me=✍:\
*.ms=✍:\
*.png=🖼:\
*.webp=🖼:\
*.ico=🖼:\
*.jpg=📸:\
*.jpe=📸:\
*.jpeg=📸:\
*.gif=🖼:\
*.svg=🗺:\
*.tif=🖼:\
*.tiff=🖼:\
*.xcf=🖌:\
*.html=🌎:\
*.xml=📰:\
*.gpg=🔒:\
*.css=🎨:\
*.pdf=📚:\
*.djvu=📚:\
*.epub=📚:\
*.csv=📓:\
*.xlsx=📓:\
*.tex=📜:\
*.md=📘:\
*.r=📊:\
*.R=📊:\
*.rmd=📊:\
*.Rmd=📊:\
*.m=📊:\
*.mp3=🎵:\
*.opus=🎵:\
*.ogg=🎵:\
*.m4a=🎵:\
*.flac=🎼:\
*.wav=🎼:\
*.mkv=🎥:\
*.mp4=🎥:\
*.webm=🎥:\
*.mpeg=🎥:\
*.avi=🎥:\
*.mov=🎥:\
*.mpg=🎥:\
*.wmv=🎥:\
*.m4b=🎥:\
*.flv=🎥:\
*.zip=📦:\
*.rar=📦:\
*.7z=📦:\
*.tar.gz=📦:\
*.z64=🎮:\
*.v64=🎮:\
*.n64=🎮:\
*.gba=🎮:\
*.nes=🎮:\
*.gdi=🎮:\
*.1=ℹ:\
*.nfo=ℹ:\
*.info=ℹ:\
*.log=📙:\
*.iso=📀:\
*.img=📀:\
*.bib=🎓:\
*.ged=👪:\
*.part=💔:\
*.torrent=🔽:\
*.jar=♨:\
*.java=♨:\
"

# fish-like zsh autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
