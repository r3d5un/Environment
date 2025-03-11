#!/bin/bash

cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$cwd/../utils/utils.sh"

echo_banner "PYTHON"

log "INFO" "Installing Python versions 3.10 through 3.13"
sudo zypper --non-interactive install \
	python310 \
	python311 \
	python312 \
	python313

log "INFO" "Installing Poetry package manager"
sudo -u r3d5un curl -sSL https://install.python-poetry.org | python3 -

