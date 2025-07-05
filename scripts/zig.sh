#!/bin/bash

cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$cwd/../utils/utils.sh"

echo_banner "ZIG"

require_root

log "INFO" "Installing Zig"
sudo zypper --non-interactive install zig

zig zen

