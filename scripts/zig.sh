#!/bin/bash

version="0.14.0"
tarball=zig-linux-x86_64-$version.tar.xz
tarball_path=/tmp/$tarball
url=https://ziglang.org/download/$version/$tarball
zig_dir=/usr/local/zig

cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$cwd/../utils/utils.sh"

echo_banner "ZIG"

require_root

log "INFO" "Downloading Zig $version: $url"
curl -L -o $tarball_path $url

log "INFO" "Installing Zig"
sudo mkdir -p $zig_dir
sudo rm -rf $zig_dir && tar -C /usr/local -xzf $tarball_path

zig version
