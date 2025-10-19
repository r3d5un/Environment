#!/bin/bash

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
	curl

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
