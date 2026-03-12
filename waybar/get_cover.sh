#!/bin/bash

# Define the target path
TEMP_PATH="/tmp/cover.png"

# Use a flat loop to avoid subshell function issues
playerctl metadata --follow mpris:artUrl | while read -r URL; do

    # If URL is empty, try to get it manually once (fallback)
    if [ -z "$URL" ]; then
        URL=$(playerctl metadata mpris:artUrl 2>/dev/null)
    fi

    if [ -z "$URL" ]; then
        # If still empty, no media is playing
        rm "$TEMP_PATH" 2>/dev/null
    elif [[ "$URL" == file://* ]]; then
        # It's a local file (common for MPD/Lollypop)
        cp "${URL#file://}" "$TEMP_PATH"
    elif [[ "$URL" == http* ]]; then
        # It's a remote URL (common for Spotify/Web)
        curl -s "$URL" -o "$TEMP_PATH"
    fi
done
