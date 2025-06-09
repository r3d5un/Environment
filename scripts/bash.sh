#!/bin/bash

cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$cwd/../utils/utils.sh"

echo_banner "BASH"

sudo zypper --non-interactive install stow

stow --verbose -d "$cwd/../dotfiles" -t "/home/r3d5un/" bash

