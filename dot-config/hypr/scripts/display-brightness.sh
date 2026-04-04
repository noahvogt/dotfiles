#!/bin/sh

# script to set the display backlight brightness by the passed amount ($1)

brightnessctl -e4 -n2 set "$1"

PERCENT=$(brightnessctl -m | awk -F, '{print $4}' | tr -d '%')

notify-send -i display-brightness-symbolic \
    -h int:transient:1 \
    -h int:SWAYNC_BYPASS_DND:1 \
    -h string:x-canonical-private-synchronous:brightness \
    -h int:value:"$PERCENT" \
    -t 1500 \
    "Brightness: ${PERCENT}%"
