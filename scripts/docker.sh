#!/bin/bash

cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$cwd/../utils/utils.sh"

echo_banner "DOCKER"

require_root

sudo zypper --non-interactive install \
	docker \
	docker-compose \
	docker-compose-switch

log "INFO" "Enabeling Docker service"
sudo systemctl enable --now docker

log "INFO" "Setting up docker group"
sudo usermod -G docker -a r3d5un

log "INFO" "Restarting Docker service"
sudo systemctl restart docker

log "INFO" "Running test container"
docker run --rm hello-world

