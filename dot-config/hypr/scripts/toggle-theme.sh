#!/bin/sh

# Script to toggle between light / dark mode

# Set this to where Waybar reads its config files
WAYBAR_DIR="$HOME/.config/waybar"
SWAYNC_DIR="$HOME/.config/swaync"
KITTY_DIR="$HOME/.config/kitty"

CURRENT_SCHEME=$(gsettings get org.gnome.desktop.interface color-scheme)

# Anything but an explicit light scheme counts as dark, matching the dark
# default that apply-dotfiles sets up on a fresh clone
if [ "$CURRENT_SCHEME" = "'prefer-light'" ]; then
    mode=dark
else
    mode=light
fi

gsettings set org.gnome.desktop.interface color-scheme "'prefer-$mode'"
# Copy the selected theme to theme.css
cp "$WAYBAR_DIR/$mode.css" "$WAYBAR_DIR/theme.css"
cp "$SWAYNC_DIR/$mode.css" "$SWAYNC_DIR/theme.css"
ln -sf "${mode}_theme.conf" "$KITTY_DIR/theme.conf"

# Sends signals to these processes to speed up the theme switch
killall -SIGUSR2 waybar 2>/dev/null
killall -SIGUSR1 nvim 2>/dev/null
pkill -USR1 kitty
swaync-client -rs
