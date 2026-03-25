#!/bin/bash

# Script to toggle between light / dark mode

# Set this to where Waybar reads its config files
WAYBAR_DIR="$HOME/.config/waybar"
SWAYNC_DIR="$HOME/.config/swaync"
KITTY_DIR="$HOME/.config/kitty"

CURRENT_SCHEME=$(gsettings get org.gnome.desktop.interface color-scheme)

if [ "$CURRENT_SCHEME" == "'prefer-dark'" ]; then
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
    # Copy the light theme to theme.css
    cp "$WAYBAR_DIR/light.css" "$WAYBAR_DIR/theme.css"
    cp "$SWAYNC_DIR/light.css" "$SWAYNC_DIR/theme.css"
    ln -sf "$KITTY_DIR/light_theme.conf" "$KITTY_DIR/theme.conf"
    notify-send "Light Mode" -a "System"
else
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    # Copy the dark theme to theme.css
    cp "$WAYBAR_DIR/dark.css" "$WAYBAR_DIR/theme.css"
    cp "$SWAYNC_DIR/dark.css" "$SWAYNC_DIR/theme.css"
    ln -sf "$KITTY_DIR/dark_theme.conf" "$KITTY_DIR/theme.conf"
    notify-send "Dark Mode" -a "System"
fi

# Sends signals to these processes to speed up the theme switch
killall -SIGUSR2 waybar
killall -SIGUSR1 nvim
pkill -USR1 kitty
swaync-client -rs
