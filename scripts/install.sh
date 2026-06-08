#!/bin/sh
set -e

# 1. xcode command line tools (provides clangd) — run manually if needed:
#    xcode-select --install

# 2. brew deps
brew bundle --file="$(dirname "$0")/Brewfile"

# 3. ocaml toolchain
opam install ocaml-lsp-server ocamlformat
