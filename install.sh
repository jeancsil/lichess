#!/usr/bin/env bash 

set -e

# Function to check if a command exists in the OS
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if Docker is installed
if ! command_exists docker; then
    echo "Docker not found. Please install Docker before proceeding."
    echo "Visit https://docs.docker.com/get-docker/ for installation instructions."
    exit 1
fi

# Check for pbpaste on macOS
# or xclip/xsel on Linux
if [[ "$OSTYPE" == "darwin"* ]]; then
    if ! command_exists pbpaste; then
        echo "pbpaste not found. This is required for clipboard functionality on macOS."
        echo "It should be installed by default. If it's missing, run brew install pbcopy."
        exit 1
    fi
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if ! command_exists xclip && ! command_exists xsel; then
        echo "Neither xclip nor xsel found. One of these is required for clipboard functionality on Linux."
        echo "Please install xclip or xsel using your distribution's package manager."
        exit 1
    fi
fi

# Pull from Docker Hub, the image with the 
docker pull jeancsil/lichess:latest

# Create ~/.local/bin if it doesn't exist
# this is where the lichess script will be placed
# you don't need to worry about mixing it with system scripts.
# You may need to add it to your PATH in your shell configuration file (e.g., ~/.bashrc or ~/.zshrc).
mkdir -p ~/.local/bin

# Download the lichess.sh executable script and places it at ~/.local/bin for convenience.
# This executable will simply rune the docker container with the latest image and upload the PGN to the Lichess account attached to the token.
curl -sSL https://raw.githubusercontent.com/jeancsil/lichess/main/lichess.sh > ~/.local/bin/lichess

# Make the script executable
chmod +x ~/.local/bin/lichess

echo "Lichess PGN Importer installed successfully!"
echo "Please ensure ~/.local/bin is in your PATH."
echo "You may need to add the following line to your ~/.bashrc or ~/.zshrc:"
echo "export PATH=\$PATH:~/.local/bin"
echo ""
echo "Please set your LICHESS_TOKEN environment variable before using the tool."
echo "You can get your token from https://lichess.org/account/oauth/token"
echo "Do not share your token with anyone!"
echo "Revoke it at any time from your Lichess account settings."
echo ""
echo "To get started, run:"
echo "lichess -h"
echo "Enjoy your chess games!"