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
	gcc \
	gh \
	htop \
	luarocks \
	mangohud \
	mpv \
	nodejs \
	pavucontrol \
	ripgrep \
	snapd \
	stow \
	syncthing \
	tokei \
	wine \
	winetricks \
	zig \
	s3fs-fuse
