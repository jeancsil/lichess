#!/usr/bin/env bash 

set -e  # Exit immediately if a command exits with a non-zero status.

IMAGE_NAME="{{IMAGE_NAME}}"
VERSION="{{VERSION}}"

echo "Running lichess import..."

# Get PGN from clipboard
PGN=$(pbpaste)

if [ -z "$PGN" ]; then
    echo "Error: Clipboard is empty. Please copy a PGN before running the command."
    exit 1
fi

# Run the Docker command
echo "Running Docker command..."
docker run -i --rm \
    -e LICHESS_TOKEN="$LICHESS_TOKEN" \
    -e PGN="$PGN" \
    "${IMAGE_NAME}:${VERSION}"

echo "Import completed."