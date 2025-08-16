#!/bin/bash

cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$cwd/../utils/utils.sh"

echo_banner "POSTGRES"

require_root

sudo zypper --non-interactive install \
	docker \
	docker-compose \
	docker-compose-switch

log "INFO" "Enabeling Docker service"
sudo systemctl enable --now docker

log "INFO" "Creating data directory"
sudo -u r3d5un mkdir -p /home/r3d5un/Development/Data/PostgreSQL/data

log "INFO" "Starting database"
docker compose -f /home/r3d5un/Environment/docker/postgres/docker-compose.yaml up --detach

