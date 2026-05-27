#!/bin/bash

TOGGLE_FILE="/tmp/autoclicker_running"

if [ -f "$TOGGLE_FILE" ]; then
    rm "$TOGGLE_FILE"
    exit 0
else
    touch "$TOGGLE_FILE"
fi

# The correct system-wide socket path managed by NixOS
export YDOTOOL_SOCKET="/run/ydotoold/socket"

while [ -f "$TOGGLE_FILE" ]
do
    # 0xC0 is the kernel code for a left click
    ydotool click 0xC0
    
    # 0.05 seconds delay so your system stays responsive
    sleep 0.001
done
