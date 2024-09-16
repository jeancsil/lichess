#!/usr/bin/env bash 

set -e  # Exit immediately if a command exits with a non-zero status.

echo "Running lichess import..."

# Get PGN from clipboard
PGN=$(pbpaste)

if [ -z "$PGN" ]; then
    echo "Error: Clipboard is empty. Please copy a PGN before running the command."
    exit 1
fi

# Check if PGN has headers, if not, add minimal headers
if [[ ! $PGN =~ ^\[Event ]]; then
    PGN=$(cat << EOF
[Event "?"]
[Site "?"]
[Date "????.??.??"]
[Round "?"]
[White "?"]
[Black "?"]
[Result "*"]

$PGN
EOF
)
fi

# Run the Docker command
echo "Running Docker command..."
docker run -i --rm \
    -e LICHESS_TOKEN="$LICHESS_TOKEN" \
    -e PGN="$PGN" \
    jeancsil/lichess:latest

echo "Import completed."