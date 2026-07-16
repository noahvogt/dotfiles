#!/bin/sh

get_vpn() {
    nmcli -t -f NAME,TYPE con show --active | awk -F: '/wireguard/ {if (s!="") s=s "  "; s=s "  " $1} END {print s}'
}

# Print initial status
get_vpn

# Monitor for network changes and update status
nmcli monitor | while read -r _; do
    get_vpn
done
