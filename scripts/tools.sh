#!/bin/bash

cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$cwd/../utils/utils.sh"

echo_banner "TOOLS"

sudo zypper --non-interactive install \
	btop \
	chromium \
	make \
	git \
	fd \
	gcc \
	htop \
	lua53-luarocks \
	mangohud \
	mpv \
	nodejs \
	pavucontrol \
	ripgrep \
	stow \
	tokei \
	wine \
	winetricks \
	s3fs \
	s3cmd \
	steam-devices \
	keepassxc \
	nextcloud-client \
	opi \
	google-noto-sans-cjk-fonts \
	zoxide \
	fzf \
	eza \
	bat \
	entr \
	yazi \
	lazygit \
	bitwarden \
	calibre \
	discord \
	foliate \
	lutris \
	filezilla \
	MozillaThunderbird \
	kamoso \
	remmina

