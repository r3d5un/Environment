#!/bin/bash

cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$cwd/../utils/utils.sh"

echo_banner "STARSHIP"

require_root

font_path=/tmp/iosevka.zip
if [ -e "$font_path" ]; then
	log "INFO" "$font_path already exists"
else
	log "INFO" "Downloading fonts"
	curl -L -o $font_path https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Iosevka.zip
fi

log "INFO" "Unpacking zipped directory"
sudo unzip -o $font_path -d /usr/share/fonts/iosevka-nerd-font

log "INFO" "Refreshing font cache"
fc-cache -f

log "INFO" "Installing Starship and dependencies"
sudo zypper --non-interactive install \
	starship \
	stow

log "INFO" "Making configuration directory"
sudo -u r3d5un mkdir -p /home/r3d5un/.config

log "INFO" "Stowing configuration"
stow --verbose -d "$cwd/../dotfiles" -t "/home/r3d5un/.config/" starship

