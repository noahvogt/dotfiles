#!/bin/bash

# Script to capture screenshots (Wayland)

# Directory for screenshots
SCREENSHOT_DIR="$HOME/pix/Screenshots"
mkdir -p "$SCREENSHOT_DIR"

# Filename format
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
FILENAME="Screenshot_${TIMESTAMP}_hyprland.png"
FILE_PATH="${SCREENSHOT_DIR}/${FILENAME}"

# Capture based on argument
case "$1" in
area)
    # Select an area using slurp
    grim -t png -g "$(slurp)" "$FILE_PATH"
    ;;
monitor)
    # Active monitor
    MONITOR=$(hyprctl activeworkspace -j | jq -r '.monitor')
    grim -t png -o "$MONITOR" "$FILE_PATH"
    ;;
window)
    # Active window
    WINDOW_DATA=$(hyprctl activewindow -j)
    if [ "$(echo "$WINDOW_DATA" | jq -r '.address')" == "null" ]; then
        notify-send "Screenshot failed" "No active window found" -u low
        exit 1
    fi
    WINDOW_AT=$(echo "$WINDOW_DATA" | jq -r '.at | join(",")')
    WINDOW_SIZE=$(echo "$WINDOW_DATA" | jq -r '.size | join("x")')
    grim -t png -g "${WINDOW_AT} ${WINDOW_SIZE}" "$FILE_PATH"
    ;;
*)
    echo "Usage: $0 {area|monitor|window}"
    exit 1
    ;;
esac

# Check if file was created and copy to clipboard
if [ -f "$FILE_PATH" ]; then
    wl-copy -t image/png <"$FILE_PATH"
fi
