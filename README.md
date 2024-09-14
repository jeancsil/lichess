# Lichess PGN Importer

This is a simple tool to import a PGN file into Lichess. It uses the Lichess API to import the game and then prints the URL of the game.

## Prerequisites

- [Java 21](https://formulae.brew.sh/cask/temurin@21#default) | `brew install --cask temurin@21`
- [Lichess.org API Token](https://lichess.org/account/oauth/token) | [+info](https://lichess.org/api#section/Authentication)
- [GNU Make 3.81](https://www.gnu.org/software/make/) | `brew install make`
- [Gradle 8.10.1](https://gradle.org/install/) | `brew install gradle`

## Configuration

You must create a `.lichess.token` file in the root of the project with the Lichess API token.  

```text
lip_exampleT0kenF0rL1chess123
```

## Installation

```bash
make install
```

## Usage

Copy the PGN from chess.com, or other source, and run the command:

```bash
lichess
```

The output will be the URL of the game in Lichess.
e.g.

```bash
https://lichess.org/xXXXxXXx
```