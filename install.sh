#!/usr/bin/env bash 

set -e

# Check if Docker is installed, if not, install it
if ! command -v docker &> /dev/null; then
    echo "Docker not found. Please, install Docker."
fi

# Pull the Docker image
docker pull jeancsil/lichess:latest

# Install pbpaste if not present (macOS-specific)
if [[ "$OSTYPE" == "darwin"* ]]; then
    if ! command -v pbpaste &> /dev/null; then
        echo "pbpaste not found. Install it with brew install pbcopy"
    fi
fi

# Download the lichess_import.sh script
curl -sSL https://raw.githubusercontent.com/jeancsil/lichess/main/lichess_import.sh -o /usr/local/bin/lichess_import.sh

# Make the script executable
chmod +x /usr/local/bin/lichess_import.sh

# Create a symlink named 'lichess' pointing to lichess_import.sh
ln -s /usr/local/bin/lichess_import.sh /usr/local/bin/lichess

echo "Lichess PGN Importer installed successfully!"
echo "Please set your LICHESS_TOKEN environment variable before using the tool."