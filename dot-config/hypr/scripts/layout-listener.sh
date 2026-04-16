#!/bin/sh

# Script run by a waybar module that displays an icon of the current hyprland
# layout. Triggered via a toggle script and hyperland socket events.
# Also tracks gemini-cli status. Combined into one script for efficency.

# PID for signaling
PID_FILE="${XDG_RUNTIME_DIR:-/tmp}/hypr_layout_persistent.pid"
echo $$ >"$PID_FILE"

# Track Gemini states (persistent file to handle subshell communication)
STATE_FILE="${XDG_RUNTIME_DIR:-/tmp}/gemini_states"
touch "$STATE_FILE"

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

handle_gemini() {
    addr="0x$1"
    win_info=$(hyprctl clients -j | jq -r ".[] | select(.address == \"$addr\")")
    [ -z "$win_info" ] && return

    title=$(echo "$win_info" | jq -r '.title')
    ws=$(echo "$win_info" | jq -r '.workspace.id')

    current="idle"
    case "$title" in
    *"✋"*) current="action" ;;
    *"✦"*) current="working" ;;
    *"◇"*) current="ready" ;;
    esac

    last_state=$(grep "$addr" "$STATE_FILE" | cut -d' ' -f2)

    if [ "$current" = "action" ] && [ "$last_state" != "action" ]; then
        action=$(notify-send "Gemini (WS $ws)" "Action Required: ✋" --action="f=Focus" -u critical -a "Gemini")
        [ "$action" = "f" ] && hyprctl dispatch focuswindow address:"$addr"

    elif [ "$current" = "ready" ] && [ "$last_state" = "working" ]; then
        action=$(notify-send "Gemini (WS $ws)" "Task Finished ◇" --action="f=Focus" -u normal -a "Gemini")
        [ "$action" = "f" ] && hyprctl dispatch focuswindow address:"$addr"
    fi

    sed -i "/$addr/d" "$STATE_FILE"
    echo "$addr $current" >>"$STATE_FILE"
}

# Trap for manual updates from your toggle script
# This will now trigger instantly because of the 'wait' loop below
trap 'print_layout' USR1

# Initial print for Waybar
print_layout

# Background the event listener
socat -U - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do
    case "$line" in
    workspace* | layoutmsg* | activelayout*)
        print_layout
        ;;
    windowtitle*)
        addr_raw=${line#*>>}
        handle_gemini "$addr_raw"
        ;;
    esac
done &

# The "Signal Listener" Loop
# This uses zero CPU but allows the script to catch USR1 immediately
while true; do
    sleep 3600 &
    wait $!
done
