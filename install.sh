#!/usr/bin/env bash 

set -e

# Check if Docker is installed, if not, provide instructions
if ! command -v docker &> /dev/null; then
    echo "Docker not found. Please install Docker before proceeding."
    echo "Visit https://docs.docker.com/get-docker/ for installation instructions."
    exit 1
fi

# Pull the Docker image
docker pull jeancsil/lichess:latest

# Create ~/.local/bin if it doesn't exist
mkdir -p ~/.local/bin

# Download the lichess.sh script
curl -sSL https://raw.githubusercontent.com/jeancsil/lichess/main/lichess.sh -o ~/.local/bin/lichess

# Make the script executable
chmod +x ~/.local/bin/lichess.sh

echo "Lichess PGN Importer installed successfully!"
echo "Please ensure ~/.local/bin is in your PATH."
echo "You may need to add the following line to your ~/.bashrc or ~/.zshrc:"
echo "export PATH=\$PATH:~/.local/bin"
echo ""
echo "Please set your LICHESS_TOKEN environment variable before using the tool."