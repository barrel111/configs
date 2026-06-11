#!/bin/bash
# typst-preview.sh

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 /path/to/typ"
    exit 1
fi

FILE="$1"
PDF="${FILE%.typ}.pdf"

typst watch "$FILE" &
TYPST_PID=$!

until [ -f "$PDF" ]; do sleep 0.2; done
sioyek "$PDF" &

trap "kill $TYPST_PID 2>/dev/null" EXIT INT TERM
wait $TYPST_PID
