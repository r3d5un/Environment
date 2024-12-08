#!/bin/bash

version="2.5.2"

cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$cwd/../utils/utils.sh"

echo_banner "JETBRAINS"

require_root

file_path=/tmp/jetbrains.tar.gz
if [ -e "$file_path" ]; then
	log "INFO" "$file_path already exists"
else
	log "INFO" "Downloading JetBrains Toolbox"
	curl -L -o $file_path https://download.jetbrains.com/toolbox/jetbrains-toolbox-$version.35332.tar.gz
fi

log "INFO" "Installing JetBrains Toolbox"
sudo rm -rf /opt/jetbrains && tar -C /opt -xzf $file_path

log "INFO" "Stowing IdeaVim configuration"
stow --verbose -d $cwd/../dotfiles -t /home/r3d5un/ ideavim
