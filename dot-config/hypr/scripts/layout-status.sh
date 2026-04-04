#!/bin/sh

# Script to output the current Hyprland layout for Waybar
# Icons:  (Master)  (Monocle)  (Dwindle)

LAYOUT=$(hyprctl -j activeworkspace | jq -r '.tiledLayout')

# If layout is empty/null, default to whatever the general config says
if [ -z "$LAYOUT" ] || [ "$LAYOUT" = "null" ]; then
    LAYOUT=$(hyprctl -j getoption general:layout | jq -r '.str')
fi

case "$LAYOUT" in
"master")
    echo ""
    ;;
"monocle")
    echo ""
    ;;
"dwindle")
    echo ""
    ;;
*)
    echo "$LAYOUT"
    ;;
esac
