#!/bin/bash

# Get current Bluetooth state
state=$(bluetoothctl show | grep Powered | awk '{print $2}')

# Choose icon based on state
if [ "$state" = "yes" ]; then
    icon=""  # Bluetooth ON
    notify-send "Bluetooth" "Bluetooth is ON" -i bluetooth
else
    icon=""  # Bluetooth OFF
    notify-send "Bluetooth" "Bluetooth is OFF" -i bluetooth
fi

# Optionally show connected devices
connected=$(bluetoothctl info | grep "Connected: yes" | awk '{print $2}')
if [ ! -z "$connected" ]; then
    notify-send "Bluetooth" "Connected devices: $connected" -i bluetooth
fi

# Echo icon back for swaync to display
echo "$icon"
