#!/bin/bash

cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$cwd/utils/utils.sh"

require_root

sudo apt update && sudo apt upgrade -y

sudo apt install -y \
	btop \
	make \
	git \
	gcc \
	htop \
	mpv \
	pavucontrol \
	ripgrep \
	stow \
	wine \
	winetricks \
	s3fs \
	s3cmd \
	keepassxc \
	nextcloud-desktop \
	zoxide \
	fzf \
	eza \
	bat \
	entr \
	foliate \
	lutris \
	filezilla \
	kamoso \
	remmina \
	fd-find \
	ca-certificates \
	curl \
	ansible \
	unzip \
	stow

log "INFO" "Setting up Docker"
sudo sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update

sudo apt install -y \
	docker-ce \
	docker-ce-cli \
	containerd.io \
	docker-buildx-plugin \
	docker-compose-plugin

sudo systemctl enable --now docker

sudo usermod -G docker -a r3d5un

sudo systemctl restart docker

docker run --rm hello-world

log "INFO" "Setting up .NET"
sudo add-apt-repository ppa:dotnet/backports -y
sudo apt update && sudo apt install -y dotnet-sdk-9.0

log "INFO" "Setting up Flatpak and Flatpak Applications"
sudo apt install flatpak -y
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak install flathub -y \
	com.github.tchx84.Flatseal \
	com.obsproject.Studio \
	md.obsidian.Obsidian \
	net.ankiweb.Anki \
	org.qbittorrent.qBittorrent \
	org.signal.Signal \
	org.torproject.torbrowser-launcher \
	rest.insomnia.Insomnia \
	us.zoom.Zoom \
	com.calibre_ebook.calibre \
	net.pcsx2.PCSX2

flatpak update -y

log "INFO" "Installing Iosevka font"
font_path=/tmp/iosevka.zip
if [ -e "$font_path" ]; then
	log "INFO" "$font_path already exists"
else
	log "INFO" "Downloading fonts"
	curl -L -o $font_path https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Iosevka.zip
fi

log "INFO" "Unpacking zipped directory"
sudo unzip -o $font_path -d /usr/share/fonts/iosevka-nerd-font

log "INFO" "Refreshing font cache"
fc-cache -f

log "INFO" "Setting up Ghostty"
snap install ghostty --classic

log "INFO" "Making configuration directory"
sudo -u r3d5un mkdir -p /home/r3d5un/.config/ghostty

log "INFO" "Stowing configuration"
stow --verbose -d "$cwd/dotfiles" -t /home/r3d5un/.config/ghostty/ ghostty

