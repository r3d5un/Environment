#!/bin/bash

cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$cwd/../utils/utils.sh"

echo_banner "KUBERNETES"

require_root

log "INFO" "Adding the Kubernetes repository"

cat <<EOF | sudo tee /etc/zypp/repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.32/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.32/rpm/repodata/repomd.xml.key
EOF

sudo zypper --non-interactive install \
	minikube \
	minikube-bash-completion \
	kubectl \
	helm \
	docker \
	docker-compose \
	docker-compose-switch

log "INFO" "Setting up Docker backend for Minikube"
sudo systemctl enable --now docker
sudo usermod -G docker -a r3d5un
sudo systemctl restart docker

log "INFO" "Checking Minikube status"
minikube status

