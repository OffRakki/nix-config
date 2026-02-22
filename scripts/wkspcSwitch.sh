#!/bin/bash
# Usage: ./wkspcSwitch.sh [workspace_number]

# 1. Find which monitor this workspace is assigned to in your config
# We use hyprctl to find the monitor bound to the workspace ID
TARGET_MONITOR=$(hyprctl workspaces -j | jq -r ".[] | select(.id == $1) | .monitor")

# 2. If the workspace is already active on a monitor, focus that monitor
if [ "$TARGET_MONITOR" != "" ] && [ "$TARGET_MONITOR" != "null" ]; then
    hyprctl dispatch focusmonitor "$TARGET_MONITOR"
fi

# 3. Now switch to the workspace (it will now stay on its monitor)
hyprctl dispatch workspace "$1"
