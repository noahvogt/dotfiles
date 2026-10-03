[ -f "$HOME/.config/exportrc" ] && . "$HOME/.config/exportrc"

if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    exec start-hyprland
fi
