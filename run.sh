#!/bin/bash

cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$cwd/utils/utils.sh"

require_root

log "INFO" "Updating system"
ansible-playbook -i hosts.yaml playbooks/workstation/update.yaml --limit localhost --become
ansible-playbook -i hosts.yaml playbooks/homelab/docker-install.yaml --limit localhost --become
ansible-playbook -i hosts.yaml playbooks/workstation/install-dotnet.yaml --limit localhost --become
ansible-playbook -i hosts.yaml playbooks/workstation/install-go.yaml --limit localhost --become
ansible-playbook -i hosts.yaml playbooks/workstation/iosevka-font.yaml --limit localhost --become

log "INFO" "Stowing configurations"
stow --verbose -d "$cwd/dotfiles" -t "/home/r3d5un/" bash
sudo -u r3d5un mkdir -p /home/r3d5un/.config/ghostty
stow --verbose -d "$cwd/dotfiles" -t /home/r3d5un/.config/ghostty/ ghostty
stow --verbose -d "$cwd/dotfiles" -t /home/r3d5un/ ideavim
sudo -u r3d5un mkdir -p /home/r3d5un/.config/nvim
stow --verbose -d "$cwd/dotfiles" -t /home/r3d5un/.config/nvim/ nvim

log "INFO" "Installing Go tooling"
export PATH="/usr/local/go/bin:$PATH"

sudo -u r3d5un env PATH="/usr/local/go/bin:$PATH" go install honnef.co/go/tools/cmd/staticcheck@latest
sudo -u r3d5un env PATH="/usr/local/go/bin:$PATH" go install -tags 'postgres,sqlserver,mysql,mariadb' github.com/golang-migrate/migrate/v4/cmd/migrate@latest
sudo -u r3d5un env PATH="/usr/local/go/bin:$PATH" go install github.com/segmentio/golines@latest
sudo -u r3d5un env PATH="/usr/local/go/bin:$PATH" go install github.com/air-verse/air@latest
sudo -u r3d5un env PATH="/usr/local/go/bin:$PATH" go install github.com/swaggo/swag/cmd/swag@latest
sudo -u r3d5un env PATH="/usr/local/go/bin:$PATH" go install golang.org/x/tools/go/analysis/passes/fieldalignment/cmd/fieldalignment@latest
sudo -u r3d5un env PATH="/usr/local/go/bin:$PATH" go install google.golang.org/protobuf/cmd/protoc-gen-go@latest

log "INFO" "Setting up NVM"
sudo -u r3d5un curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | sudo -u r3d5un bash

log "INFO" "Setting up Password Store"
secrets_dir="$cwd/secrets"
log "INFO" "Checking for PGP keys in $secrets_dir"
if [[ ! -e "$secrets_dir/public.pgp" || ! -e "$secrets_dir/private.pgp" ]]; then
	log "ERROR" "private or public key not found in $secrets_dir"
	exit 1
else
	log "INFO" "Importing private PGP key"
	sudo -u r3d5un gpg --import "$secrets_dir/private.pgp"

	log "INFO" "Importing public PGP key"
	sudo -u r3d5un gpg --import "$secrets_dir/public.pgp"
fi

light_gray='\033[0m'
no_color='\033[0m'

echo -e "\n\nIn order for password store to work you need to trust the key\n"
echo -e "Run: ${light_gray}gpg --edit-key email@address.io${no_color}\n"
echo -e "Run the trust command, e.g.\n"
echo -e "${light_gray}gpg> trust${no_color}\n"
echo -e "Set trust level to the highest possible (5) when prompted:\n"
echo -e "${light_gray}Your decision? 5${no_color}\n"
echo -e "Quit and save:\n"
echo -e "${light_gray}quit${no_color}\n\n"

sudo -u r3d5un pass

log "INFO" "Setting up Rust"
sudo -u r3d5un curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sudo -u r3d5un sh -s -- -y

log "INFO" "Setting up Starship"
cargo install starship --locked
sudo -u r3d5un mkdir -p /home/r3d5un/.config
stow --verbose -d "$cwd/dotfiles" -t "/home/r3d5un/.config/" starship

log "INFO" "Installing PostgreSQL"
sudo apt install curl ca-certificates
sudo install -d /usr/share/postgresql-common/pgdg
sudo curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc

. /etc/os-release
sudo sh -c "echo 'deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt $VERSION_CODENAME-pgdg main' > /etc/apt/sources.list.d/pgdg.list"

sudo apt update

sudo apt install postgresql-18

log "INFO" "Installing Grafana Alloy"
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee /etc/apt/sources.list.d/grafana.list

sudo apt update
sudo apt install alloy

log "INFO" "Installing Node Version Manager"
sudo -u r3d5un curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | sudo -u r3d5un bash

log "INFO" "Installing Mullvad VPN"
sudo curl -fsSLo /usr/share/keyrings/mullvad-keyring.asc https://repository.mullvad.net/deb/mullvad-keyring.asc
echo "deb [signed-by=/usr/share/keyrings/mullvad-keyring.asc arch=$( dpkg --print-architecture )] https://repository.mullvad.net/deb/stable stable main" | sudo tee /etc/apt/sources.list.d/mullvad.list
sudo apt update
sudo apt install mullvad-vpn

log "INFO" "Installing Kubectl"
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.35/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.35/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list

sudo apt update
sudo apt install -y kubectl

log "INFO" "Installing Tailscale"
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/noble.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/noble.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list

sudo apt update
sudo apt install tailscale

log "INFO" "Installing SOPS"
sudo -u r3d5un mkdir -p /home/r3d5un/.local/bin/sops && \
	sudo -u r3d5un curl -Lo /home/r3d5un/.local/bin/sops/sops https://github.com/getsops/sops/releases/download/v3.11.0/sops-v3.11.0.linux.amd64 && \
	sudo -u r3d5un chmod +x /home/r3d5un/.local/bin/sops/sops && \
	sudo -u r3d5un chown -R r3d5un:r3d5un /home/r3d5un/.local/bin/sops

