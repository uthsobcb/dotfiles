#!/bin/bash

# Directory to save screenshots
DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"

# Timestamp for filename
FILE="$DIR/screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"

# Menu to choose screenshot type
TYPE=$(printf "Full Screen\nArea\nActive Window" | rofi -dmenu -p "Screenshot Type")

case "$TYPE" in
    "Full Screen")
        grim "$FILE"
        ;;
    "Area")
        # Select area using slurp
        grim -g "$(slurp)" "$FILE"
        ;;
    "Active Window")
        # Get focused window geometry via swaymsg
        FOCUS=$(swaymsg -t get_tree | jq '.. | select(.focused? == true).rect')
        X=$(echo "$FOCUS" | jq '.x')
        Y=$(echo "$FOCUS" | jq '.y')
        W=$(echo "$FOCUS" | jq '.width')
        H=$(echo "$FOCUS" | jq '.height')
        grim -g "${X},${Y} ${W}x${H}" "$FILE"
        ;;
    *)
        exit 0
        ;;
esac

# Copy to clipboard if wl-copy exists
if command -v wl-copy &>/dev/null; then
    wl-copy < "$FILE"
fi

# Send notification
if command -v notify-send &>/dev/null; then
    notify-send "Screenshot Taken" "Saved to $FILE" -i camera-photo
fi
