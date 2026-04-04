#!/bin/sh

# Script run by a waybar module that displays an icon of the current hyprland
# layout. Triggered via a toggle script and hyperland socket events.

# Save the parent process ID so toggle-layout.sh can signal it
PID_FILE="${XDG_RUNTIME_DIR:-/tmp}/hypr_layout_persistent.pid"
echo $$ >"$PID_FILE"

print_layout() {
    LAYOUT=$(hyprctl -j activeworkspace | jq -r '.tiledLayout')
    if [ -z "$LAYOUT" ] || [ "$LAYOUT" = "null" ]; then
        LAYOUT=$(hyprctl -j getoption general:layout | jq -r '.str')
    fi

    case "$LAYOUT" in
    "master") echo "" ;;
    "monocle") echo "" ;;
    "dwindle") echo "" ;;
    *) echo "$LAYOUT" ;;
    esac
}

# When USR1 is received from toggle-layout.sh, print the layout
trap 'print_layout' USR1

# Print once at startup
print_layout

# Background task: listen for Hyprland events and print layout directly
# This subshell inherits stdout, so Waybar sees the output instantly
socat -U - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do
    case "$line" in
    workspace* | layoutmsg* | activelayout*)
        print_layout
        ;;
    esac
done &

# Keep the parent script alive to receive signals from toggle-layout.sh
while true; do
    sleep 3600 &
    wait $!
done
