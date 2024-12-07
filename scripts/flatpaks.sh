#!/bin/bash

cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$cwd/../utils/utils.sh"

echo_banner "UPDATING FLATPAKS"

require_root

sudo dnf install flatpak

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak install flathub \
	com.bitwarden.desktop \
	com.calibre_ebook.calibre \
	com.discordapp.Discord \
	com.github.johnfactotum.Foliate \
	com.github.tchx84.Flatseal \
	com.logseq.Logseq \
	com.obsproject.Studio \
	com.spotify.Client \
	com.valvesoftware.Steam \
	md.obsidian.Obsidian \
	net.ankiweb.Anki \
	net.lutris.Lutris \
	org.filezillaproject.Filezilla \
	org.gnome.Extensions \
	org.gnome.Extensions \
	org.mozilla.Thunderbird \
	org.qbittorrent.qBittorrent \
	org.remmina.Remmina \
	org.signal.Signal \
	org.torproject.torbrowser-launcher \
	rest.insomnia.Insomnia \
	sh.ppy.osu

flatpak update -y
