#!/bin/bash
# typst-preview.sh

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 /path/to/typ" >&2
    exit 1
fi

FILE="$1"
PDF="${FILE%.typ}.pdf"
TYPST_PID=

cleanup() {
    if [ -n "$TYPST_PID" ]; then
        kill "$TYPST_PID" 2>/dev/null
        wait "$TYPST_PID" 2>/dev/null
    fi
}

# Cover shutdown while waiting for the first PDF as well as after opening it.
trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

typst watch "$FILE" &
TYPST_PID=$!

until [ -f "$PDF" ]; do
    if ! kill -0 "$TYPST_PID" 2>/dev/null; then
        wait "$TYPST_PID"
        WATCH_STATUS=$?
        TYPST_PID=
        echo "Typst: watcher exited before producing $PDF" >&2
        # Even a clean exit is a failure if no PDF was produced.
        if [ "$WATCH_STATUS" -eq 0 ]; then WATCH_STATUS=1; fi
        exit "$WATCH_STATUS"
    fi
    sleep 0.2
done
sioyek "$PDF" &

wait "$TYPST_PID"
WATCH_STATUS=$?
TYPST_PID=
exit "$WATCH_STATUS"
