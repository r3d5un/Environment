#!/bin/bash

cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$cwd/../utils/utils.sh"

echo_banner "SYNCTHING"

require_root

sudo dnf install syncthing -y

sudo systemctl enable --now syncthing@r3d5un.service

systemctl status syncthing@r3d5un.service
