#!/bin/bash

BAT=/sys/class/power_supply/BAT0

CAP=$(cat $BAT/capacity)
STAT=$(cat $BAT/status)

# Icons (Nerd Fonts)
if [ "$STAT" = "Charging" ]; then
    ICON="󰂄"
else
    if   [ $CAP -ge 90 ]; then ICON="󰁹"
    elif [ $CAP -ge 75 ]; then ICON="󰁽"
    elif [ $CAP -ge 60 ]; then ICON="󰁼"
    elif [ $CAP -ge 40 ]; then ICON="󰁻"
    elif [ $CAP -ge 20 ]; then ICON="󰁺"
    else ICON="󰂎"
    fi
fi

echo "$ICON  $CAP%"
