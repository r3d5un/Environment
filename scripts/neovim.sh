#!/bin/bash

cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$cwd/../utils/utils.sh"

echo_banner "NEOVIM"

sudo dnf install -y \
	neovim \
	fd-find \
	ripgrep
