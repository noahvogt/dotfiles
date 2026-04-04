#!/bin/sh

# Script to toggle between master and monocle layouts for the active hyprland
# workspace

WS_INFO=$(hyprctl -j activeworkspace)
WS_ID=$(echo "$WS_INFO" | jq -r '.id')
CURRENT_LAYOUT=$(echo "$WS_INFO" | jq -r '.tiledLayout')

if [ "$CURRENT_LAYOUT" = "master" ]; then
    hyprctl keyword "workspace $WS_ID,layout:monocle"
else
    hyprctl keyword "workspace $WS_ID,layout:master"
fi

# Signal the persistent layout script accurately (by pid file)
PID_FILE="${XDG_RUNTIME_DIR:-/tmp}/hypr_layout_persistent.pid"
if [ -f "$PID_FILE" ]; then
    kill -USR1 "$(cat "$PID_FILE")" 2>/dev/null
fi
