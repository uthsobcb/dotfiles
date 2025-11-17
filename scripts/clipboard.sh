#!/bin/bash

# Select clipboard entry via rofi
SELECTION=$(cliphist list | rofi -dmenu | cliphist decode)

# Copy it to clipboard
echo -n "$SELECTION" | wl-copy

# Send notification if selection is not empty
if [[ -n "$SELECTION" ]]; then
    notify-send "Clipboard" "Copied: $SELECTION" -i clipboard
fi
