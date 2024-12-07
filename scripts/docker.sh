#!/bin/bash

cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$cwd/../utils/utils.sh"

echo_banner "DOCKER SETUP"

require_root

log "INFO" "Checking if the Docker repository is enabled"
if dnf repolist | grep -q "docker-ce-stable"; then
	log "INFO" "Docker repository enabled"
else
	log "INFO" "Docker repository not found. Adding repository..."

	log "INFO" "Enabeling DNF plugins"
	sudo dnf -y install dnf-plugins-core
	log "INFO" "Adding Docker repository"
	sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

	log "INFO" "Repository added"
fi

sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

sudo systemctl enable --now docker

docker run hello-world
