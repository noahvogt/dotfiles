#!/bin/sh

get_vpn() {
    nmcli -t -f NAME,TYPE con show --active | awk -F: '
        $2 == "wireguard" || $2 == "vpn" {
            if (s != "") s = s "  "
            s = s ($2 == "vpn" ? "" : "") "  " $1
        }
        END { print s }
    '
}

# Print initial status
get_vpn

# Monitor for network changes and update status
nmcli monitor | while read -r _; do
    get_vpn
done
