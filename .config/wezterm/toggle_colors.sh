#!/bin/bash

CONFIG_DIR="$HOME/.config/wezterm"
STATE_FILE="$CONFIG_DIR/state.txt"
ACTIVE_FILE="$CONFIG_DIR/active_theme.lua"

if [ ! -f "$STATE_FILE" ]; then
    echo "dark" > "$STATE_FILE"
fi

CURRENT_MODE=$(cat "$STATE_FILE" | tr -d '[:space:]')

if [ "$CURRENT_MODE" == "dark" ]; then
    # Switch to Light
    cp "$CONFIG_DIR/light.lua" "$ACTIVE_FILE"
    echo "light" > "$STATE_FILE"
else
    # Switch to Dark
    cp "$CONFIG_DIR/dark.lua" "$ACTIVE_FILE"
    echo "dark" > "$STATE_FILE"
fi
