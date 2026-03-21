#!/usr/bin/env bash

# Set this to where Waybar reads its config files
WAYBAR_DIR="$HOME/.config/waybar"

CURRENT_SCHEME=$(gsettings get org.gnome.desktop.interface color-scheme)

if [ "$CURRENT_SCHEME" == "'prefer-dark'" ]; then
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
    # Copy the light theme to theme.css
    cp "$WAYBAR_DIR/light.css" "$WAYBAR_DIR/theme.css"
    notify-send "Light Mode" -a "System"
else
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    # Copy the dark theme to theme.css
    cp "$WAYBAR_DIR/dark.css" "$WAYBAR_DIR/theme.css"
    notify-send "Dark Mode" -a "System"
fi

# Send SIGUSR2 to Waybar so it dynamically reloads style.css (which now imports theme.css)
killall -SIGUSR2 waybar
