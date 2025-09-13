#!/bin/bash

MAGNET_LINK=$(cat magnet.txt)

if [ -z "$MAGNET_LINK" ]; then
    echo "No magnet link found in magnet.txt"
    exit 1
fi

aria2c \
    --seed-time=0 \
    --bt-save-metadata=true \
    --dir="$HOME/Downloads" \
    --file-allocation=none \
    "$MAGNET_LINK"

if [ $? -eq 0 ]; then
    osascript -e 'display notification "Download Completed!" with title "aria2c"'
    > magnet.txt
    echo "magnet.txt cleared after successful download"
else
    osascript -e 'display notification "Download Failed!" with title "aria2c"'
fi
