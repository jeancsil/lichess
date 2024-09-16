#!/usr/bin/env bash 

set -e

# Function to check if a command exists
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
if [[ "$OSTYPE" == "darwin"* ]]; then
    if ! command_exists pbpaste; then
        echo "pbpaste not found. This is required for clipboard functionality on macOS."
        echo "It should be installed by default. If it's missing, run brew install pbcopy."
        exit 1
    fi
# elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
#     if ! command_exists xclip && ! command_exists xsel; then
#         echo "Neither xclip nor xsel found. One of these is required for clipboard functionality on Linux."
#         echo "Please install xclip or xsel using your distribution's package manager."
#         exit 1
#     fi
fi

# Pull the Docker image
docker pull jeancsil/lichess:latest

# Create ~/.local/bin if it doesn't exist
mkdir -p ~/.local/bin

# Download the lichess.sh script and replace placeholders
curl -sSL https://raw.githubusercontent.com/jeancsil/lichess/main/lichess.sh | \
sed -e "s|{{IMAGE_NAME}}|jeancsil/lichess|g" \
    -e "s|{{VERSION}}|latest|g" \
> ~/.local/bin/lichess

# Make the script executable
chmod +x ~/.local/bin/lichess

echo "Lichess PGN Importer installed successfully!"
echo "Please ensure ~/.local/bin is in your PATH."
echo "You may need to add the following line to your ~/.bashrc or ~/.zshrc:"
echo "export PATH=\$PATH:~/.local/bin"
echo ""
echo "Please set your LICHESS_TOKEN environment variable before using the tool."