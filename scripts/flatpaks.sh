#!/bin/bash

cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$cwd/../utils/utils.sh"

echo_banner "FLATPAKS"

require_root

sudo zypper --non-interactive install flatpak

sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

sudo flatpak install flathub -y \
	com.github.tchx84.Flatseal \
	com.obsproject.Studio \
	md.obsidian.Obsidian \
	net.ankiweb.Anki \
	org.qbittorrent.qBittorrent \
	org.signal.Signal \
	org.torproject.torbrowser-launcher \
	rest.insomnia.Insomnia \
	us.zoom.Zoom

sudo flatpak update -y

