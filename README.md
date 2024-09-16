# Lichess PGN Importer

This is a simple tool to import a PGN file into Lichess. It uses the Lichess API to import the game and then prints the URL of the game.

## Prerequisites

- [Docker](https://www.docker.com/get-started)
- [Lichess.org API Token](https://lichess.org/account/oauth/token) | [+info](https://lichess.org/api#section/Authentication)
<!-- - [GNU Make 3.81](https://www.gnu.org/software/make/) | `brew install make` -->

## Quick Install

Run this command to install the Lichess PGN Importer:

```bash
curl -sSL https://raw.githubusercontent.com/jeancsil/lichess/main/install.sh | bash
```

This script will:

1. Install Docker if not already installed
2. Pull the necessary Docker image
3. Install `pbpaste` if not present (for clipboard functionality on macOS)
4. Set up the `lichess` command for easy execution

Note: You may need to use `sudo` for the installation if you don't have the necessary permissions.

After installation, make sure to set your Lichess API token as an environment variable:


## Configuration

Set your Lichess API token as an environment variable:

```bash
export LICHESS_TOKEN=lip_exampleT0kenF0rL1chess123
```

## Installation

```bash
make install
```

## Usage

1. Copy a valid PGN (Portable Game Notation) for a chess game to your clipboard.

2. Ensure your `LICHESS_TOKEN` environment variable is set:

   ```bash
   export LICHESS_TOKEN=your_lichess_api_token_here
   ```

3. Run the `lichess` command:

   ```bash
   lichess
   ```

   The application will read the PGN from your clipboard, save it to a temporary file, import it to Lichess, and provide you with the URL of the imported game.

Example output:

```bash
https://lichess.org/xX
```
