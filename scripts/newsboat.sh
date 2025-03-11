#!/bin/bash

cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$cwd/../utils/utils.sh"

echo_banner "NEWSBOAT"

sudo zypper --non-interactive install \
	newsboat \
	stow

stow --verbose -d $cwd/../dotfiles -t /home/r3d5un/.newsboat/ newsboat

