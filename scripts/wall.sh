#!/bin/bash

sleep 1

# Uncomment and set primary monitor if using multiple monitors
# primary_monitor=$(cat "$HOME/.config/scripts/mainmonitor")
# wallpaper=$(swww query | grep "^: $primary_monitor:" | sed 's/.*image: //')

# For single monitor (eDP-1), use this line:
wallpaper=$(swww query | grep "^: eDP-1:" | sed 's/.*image: //')

genwal=$wallpaper
wallname=$(echo $genwal | sed 's/.*\///')

rm ~/.config/scripts/wallpaper
ln -s $genwal ~/.config/scripts/wallpaper
echo "* { wallpaper: url(\"$genwal\", width); }" > "$HOME/.config/rofi/options/wallpaper.rasi"

wal -q -i $genwal &

sleep 0.5

~/.config/scripts/waybar.sh &

notify-send -i preferences-desktop-wallpaper-symbolic "Wallpaper Applied" "New color scheme generated from image:\n$wallname"

swaync-client -R
swaync-client -rs

eww reload