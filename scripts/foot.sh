#!/bin/bash

cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$cwd/../utils/utils.sh"

echo_banner "FOOT"

font_path=/tmp/iosevka.zip
if [ -e "$font_path" ]; then
	log "INFO" "$font_path already exists"
else
	log "INFO" "Downloading fonts"
	curl -L -o /tmp/iosevka.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Iosevka.zip
fi

log "INFO" "Unpacking zipped directory"
sudo unzip -o /tmp/iosevka.zip -d /usr/share/fonts/iosevka-nerd-font

log "INFO" "Refreshing font cache"
fc-cache -f

log "INFO" "Installing kitty and dependencies"
sudo zypper --non-interactive install \
	foot \
	stow

log "INFO" "Making configuration directory"
sudo -u r3d5un mkdir -p /home/r3d5un/.config/foot

log "INFO" "Stowing configuration"
stow --verbose -d $cwd/../dotfiles -t /home/r3d5un/.config/foot/ foot
