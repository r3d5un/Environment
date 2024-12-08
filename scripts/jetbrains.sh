#!/bin/bash

version="2.5.2"

cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$cwd/../utils/utils.sh"

echo_banner "JETBRAINS"

require_root

log "INFO" "Downloading JetBrains Toolbox"
curl -L -o /tmp/jetbrains https://download.jetbrains.com/toolbox/jetbrains-toolbox-$version.35332.tar.gz

sudo rm -rf /opt/jetbrains && tar -C /opt -xzf /tmp/jetbrains
