#!/bin/bash

MULLVAD="/usr/bin/mullvad"
STATUS="$($MULLVAD status)"
ESCAPED_STATUS=$(echo "$STATUS" \
    | sed 's/^[[:space:]]*//' \
    | sed ':a;N;$!ba;s/\n/\\n/g; s/"/\\"/g')

if [[ "$1" == "toggle" ]]; then
    if echo "$STATUS" | grep -q "Connected"; then
        $MULLVAD disconnect
    else
        $MULLVAD connect
    fi
    exit 0
fi

if echo "$STATUS" | grep -q "Connected"; then
    echo "{\"text\":\" VPN\",\"class\":\"connected\",\"tooltip\":\"$ESCAPED_STATUS\"}"
elif echo "$STATUS" | grep -q "Connecting"; then
    echo "{\"text\":\" VPN\",\"class\":\"connecting\",\"tooltip\":\"$ESCAPED_STATUS\"}"
else
    echo "{\"text\":\" VPN\",\"class\":\"disconnected\",\"tooltip\":\"$ESCAPED_STATUS\"}"
fi
