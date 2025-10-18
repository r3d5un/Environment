#!/bin/bash

require_root

sudo apt update && sudo apt upgrade -y

sudo apt install -y \
	btop \
	make \
	git \
	fd \
	gcc \
	htop \
	mpv \
	pavucontrol \
	ripgrep \
	stow \
	wine \
	winetricks \
	s3fs \
	s3cmd \
	keepassxc \
	nextcloud-desktop \
	zoxide \
	fzf \
	eza \
	bat \
	entr \
	lazygit \
	bitwarden \
	discord \
	foliate \
	lutris \
	filezilla \
	MozillaThunderbird \
	kamoso \
	remmina

