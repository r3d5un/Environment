#!/bin/bash

cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$cwd/../utils/utils.sh"

echo_banner "FLATPAKS"

require_root

sudo zypper --non-interactive install flatpak

sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

sudo flatpak install flathub -y \
	com.bitwarden.desktop \
	com.calibre_ebook.calibre \
	com.discordapp.Discord \
	com.github.johnfactotum.Foliate \
	com.github.tchx84.Flatseal \
	com.obsproject.Studio \
	md.obsidian.Obsidian \
	net.ankiweb.Anki \
	net.lutris.Lutris \
	org.filezillaproject.Filezilla \
	org.mozilla.Thunderbird \
	org.qbittorrent.qBittorrent \
	org.remmina.Remmina \
	org.signal.Signal \
	org.torproject.torbrowser-launcher \
	rest.insomnia.Insomnia \
	us.zoom.Zoom \
	rocks.koreader.KOReader \
	flathub app.zen_browser.zen \
	io.github.pwr_solaar.solaar \
	flathub sh.ppy.osu

sudo flatpak update -y
