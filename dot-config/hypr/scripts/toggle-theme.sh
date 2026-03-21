#!/usr/bin/env bash

# Check current color scheme
CURRENT_SCHEME=$(gsettings get org.gnome.desktop.interface color-scheme)

if [ "$CURRENT_SCHEME" == "'prefer-dark'" ]; then
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
    notify-send "Light Mode" -a "System"
else
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    notify-send "Dark Mode" -a "System"
fi
