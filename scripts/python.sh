#!/bin/bash

cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$cwd/../utils/utils.sh"

echo_banner "PYTHON"

log "INFO" "Installing Python versions 3.10 through 3.12"
sudo dnf install -y \
	python 3.10 \
	python 3.11 \
	python3.12

log "INFO" "Installing Poetry package manager"
sudo -u r3d5un curl -sSL https://install.python-poetry.org | python3 -
