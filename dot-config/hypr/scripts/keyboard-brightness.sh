#!/bin/sh

# script to set the keyboard backlight brightness by the passed amount ($1)

device=$(brightnessctl -l | grep "kbd_backlight" | head -n 1 | awk '{print $2}' | tr -d "'")
brightnessctl -d "$device" set "$1"

PERCENT=$(brightnessctl -m -d "$device" | awk -F, '{print $4}' | tr -d '%')

notify-send -i keyboard-brightness-symbolic \
    -h int:transient:1 \
    -h int:SWAYNC_BYPASS_DND:1 \
    -h string:x-canonical-private-synchronous:brightness \
    -h int:value:"$PERCENT" \
    -t 1500 \
    "Brightness: ${PERCENT}%"
