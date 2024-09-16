#!/usr/bin/env bash

# Remove the lichess command
rm -f ~/.local/bin/lichess

# Remove the Docker image
docker rmi jeancsil:lichess:latest 2>/dev/null || true
docker rmi jeancsil:lichess:1.0.0 2>/dev/null || true

echo "Lichess PGN Importer has been removed."