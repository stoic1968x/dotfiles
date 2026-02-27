#!/bin/bash

OUTPUT=$(solaar show 2>/dev/null)

MOUSE=$(echo "$OUTPUT" | awk '/G502/ {found=1} found && /Battery/ {print $2; found=0}')
KEYBOARD=$(echo "$OUTPUT" | awk '/G915/ {found=1} found && /Battery/ {print $2; found=0}')

echo "󰍽 $MOUSE 󰌌 $KEYBOARD"
