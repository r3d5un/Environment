#!/bin/bash

cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$cwd/../utils/utils.sh"

echo_banner "TMUX"

require_root

sudo dnf install -y \
	tmux \
	git \
	stow

log "INFO" "Installing Tmux Plugin Manager"

tmux_dir="$cwd/../dotfiles/tmux"
if [ -e "$cwd" ]; then
	log "INFO" "tpm already installed"
else
	log "INFO" "Installing TPM"
	sudo -u r3d5un git clone https://github.com/tmux-plugins/tpm $tmux_dir/plugins/tpm
fi

log "INFO" "Sourcing configuration"
sudo -u r3d5un tmux source $tmux_dir/plugins/tpm

stow --verbose -d $cwd/../dotfiles -t /home/r3d5un/.config/tmux/ tmux

echo -e "\n\nUse prefix + I to install plugins\n\n"
