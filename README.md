# Lichess PGN Importer

Tool to import a PGN (Portable Game Notation) file into [Lichess.com](https://lichess.org/) from the clipboard.
The program outputs the URL of the imported game so you can request computer analysis for all your games effortlessly, in a few seconds.

## Why Use This Tool?

- Easily import chess games from other platforms to your **Lichess** account, **game analysis**, etc...
- Streamline your workflow for reviewing and analyzing chess games from different sources.

## Prerequisites

- [Docker](https://www.docker.com/get-started) (version 20.10 or later recommended)
- [Lichess](https://lichess.org) account and a [Personal API access tokens](https://lichess.org/account/oauth/token)

## Quick Install


Run this command to install the Lichess PGN Importer  
_(always check scripts before running it! This one is pretty simple and contains comments)_:

```bash
curl -sSL https://raw.githubusercontent.com/jeancsil/lichess/main/install.sh | bash
```

This script will:

1. Check if the necessary executables are installed (`Docker`, `pbpaste` to copy from clipboard)
2. Pull the Docker image containing the java application.
3. Add a symlink to the `lichess` executable for convenience.

After installation, make sure to set your Lichess API token as an [environment variable](#configuration).

## Configuration

Set your Lichess API token as an environment variable:

```bash
export LICHESS_TOKEN=lip_exampleT0kenF0rL1chess123
```

## Usage

1. Copy a valid PGN (Portable Game Notation) for a chess game to your clipboard.
e.g.:
![alt text](docs/PGN-chesscom.png)

2. Ensure your `LICHESS_TOKEN` environment variable is set as described earlier.

3. Run the `lichess` command:

   ```bash
   lichess
   ```

   The application will read the PGN from your clipboard, save it to a temporary file, import it to Lichess, and provide you with the URL of the imported game.

Example output:

```bash
Game imported successfully: https://lichess.org/xXxYyYZzZ
```

## Uninstall

To uninstall the Lichess PGN Importer, you can use the following command:

```bash
curl -sSL https://raw.githubusercontent.com/jeancsil/lichess/main/uninstall.sh | bash
```

This script will:

1. Remove the `lichess` command from your system
2. Remove the Docker images used by the application

Alternatively, if you have cloned the repository, you can run:

```bash
make uninstall
```

