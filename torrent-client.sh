#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MAGNET_FILE="$SCRIPT_DIR/magnet.txt"
MAGNET_LINK=$(cat "$MAGNET_FILE" | tr -d '[:space:]')

# Determine the target to download (magnet or .torrent)
if [ -n "$MAGNET_LINK" ]; then
    DOWNLOAD_TARGET="$MAGNET_LINK"
    USING_MAGNET=true
else
    TORRENT_FILE=$(find "$SCRIPT_DIR" -maxdepth 1 -type f -name "*.torrent" | head -n 1)
    if [ -z "$TORRENT_FILE" ]; then
        echo "No magnet link found in magnet.txt and no .torrent file found in the directory."
        exit 1
    fi
    DOWNLOAD_TARGET="$TORRENT_FILE"
    USING_MAGNET=false
fi

# Run aria2c
aria2c \
    --seed-time=0 \
    --bt-save-metadata=true \
    --dir="$HOME/Downloads" \
    --file-allocation=none \
    "$DOWNLOAD_TARGET"

# Post-download actions
if [ $? -eq 0 ]; then
    osascript -e 'display notification "Download Completed!" with title "aria2c"'
    if [ "$USING_MAGNET" = true ]; then
        > "$MAGNET_FILE"
        echo "magnet.txt cleared after successful download"
    fi
else
    osascript -e 'display notification "Download Failed!" with title "aria2c"'
fi
