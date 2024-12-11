#!/bin/bash

cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$cwd/../utils/utils.sh"

echo_banner "TOOLS"

sudo dnf install -y \
	alacritty \
	btop \
	chromium \
	make \
	git \
	fd-find \
	foot \
	gcc \
	gh \
	htop \
	luarocks \
	mangohud \
	mpv \
	neovim \
	nodejs \
	pass \
	pavucontrol \
	ripgrep \
	snapd \
	stow \
	syncthing \
	tokei \
	wine \
	winetricks \
	zig
