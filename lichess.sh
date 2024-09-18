#!/usr/bin/env bash 
set -e  # Exit immediately if a command exits with a non-zero status.

# The VERSION will be replaced during the installation or update process
VERSION="{{VERSION}}"

show_help() {
    echo "Imports a PGN from clipboard or stdin to Lichess."
    echo ""
    echo -e "Usage:"
    echo -e "\tlichess:\t\t\tTo import a PGN from clipboard"
    echo -e "\tlichess < /path/to/game.pgn:\tTo import a PGN from a file"
    echo -e "\tcat /path/to/game.pgn | lichess\tTo import a PGN from a pipe"
    echo -e "\techo '[PGN data]' | lichess\tTo import a PGN from stdin"

    echo
    echo "Options:"
    echo "  -h, --help     Display this help message and exit"
    echo "  -v, --version  Display version information and exit"
    echo "  -p, --pgn      Displays an example PGN with valid and accepted headers for reference"
    echo
}

show_version() {
    echo "Lichess PGN Importer v$VERSION"
}

show_pgn() {
    echo "[Event \"Opera Game\"]"
    echo "[Site \"Paris FRA\"]"
    echo "[Date \"1858.??.??\"]"
    echo "[Round \"?\"]"
    echo "[White \"Morphy, Paul\"]"
    echo "[Black \"Duke of Brunswick & Count Isouard\"]"
    echo "[Result \"1-0\"]"
    echo "[ECO \"C41\"]"
    echo "[PlyCount \"17\"]"
    echo "[EventDate \"1858.??.??\"]"
    echo ""
    echo -n "1. e4 e5 2. Nf3 d6 3. d4 Bg4 4. dxe5 Bxf3 5. Qxf3 dxe5 6. Bc4 Nf6 7. Qb3 Qe7"
    echo -n "8. Nc3 c6 9. Bg5 b5 10. Nxb5 cxb5 11. Bxb5+ Nbd7 12. O-O-O Rd8"
    echo  "13. Rxd7 Rxd7 14. Rd1 Qe6 15. Bxd7+ Nxd7 16. Qb8+ Nxb8 17. Rd8# 1-0"
}

# Check for arguments
if [ "$#" -gt 0 ]; then
    case "$1" in
        -h|--help)
            show_help
            exit 0
            ;;
        -v|--version)
            show_version
            exit 0
            ;;
        -p|--pgn)
            show_pgn
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use 'lichess --help' for usage information."
            exit 1
            ;;
    esac
fi

# Get PGN from clipboard
if [ -t 0 ]; then
    # Terminal is interactive, use clipboard
    PGN=$(pbpaste)
else
    # Data is being piped in, read from stdin
    PGN=$(cat)
fi

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
