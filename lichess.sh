#!/usr/bin/env bash 

set -e  # Exit immediately if a command exits with a non-zero status.

# Get PGN from clipboard
PGN=$(pbpaste)

# Check if clipboard is empty or PGN doesn't have headers
if [ -z "$PGN" ] || [[ ! $PGN =~ ^\[Event ]]; then
    echo "Error: Invalid PGN. Please copy a valid PGN with headers before running the command."
    exit 1
fi

# Run the Docker command
docker run -i --rm \
    -e LICHESS_TOKEN="$LICHESS_TOKEN" \
    -e PGN="$PGN" \
    jeancsil/lichess:latest
