#!/bin/bash

# Check if PDF path is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 /path/to/pdf"
    exit 1
fi

# Open PDF with sioyek, set up inverse search
sioyek --inverse-search "nvim --headless -c \"VimtexInverseSearch %2 '%1'\"" "$1" &

# Wait a moment for sioyek to fully start
sleep 1

# Toggle synctex in the running sioyek instance
sioyek --execute-command toggle_synctex

# Exit with success
exit 0
