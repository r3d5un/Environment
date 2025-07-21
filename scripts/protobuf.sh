#!/bin/bash

cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$cwd/../utils/utils.sh"

echo_banner "PROTOBUF"

PB_REL="https://github.com/protocolbuffers/protobuf/releases"

log "INFO" "Downloading protobufc"
sudo -u r3d5un curl -L -o "/tmp/protoc.zip" "$PB_REL/download/v30.2/protoc-30.2-linux-x86_64.zip"

log "INFO" "Unpacking zipped directory"
sudo unzip -o "/tmp/protoc.zip" -d "/usr/local"

