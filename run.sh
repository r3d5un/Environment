#!/bin/bash

cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$cwd/utils/utils.sh"

require_root

log "INFO" "Updating system"
ansible-playbook -i hosts.yaml playbooks/workstation/update.yaml --limit localhost --become
ansible-playbook -i hosts.yaml playbooks/homelab/docker-install.yaml --limit localhost --become

log "INFO" "Setting up Bash"
stow --verbose -d "$cwd/dotfiles" -t "/home/r3d5un/" bash

log "INFO" "Setting up .NET"
sudo add-apt-repository ppa:dotnet/backports -y
sudo apt update && sudo apt install -y dotnet-sdk-9.0

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

log "INFO" "Installing Go"
version="1.25.5"
tarball=go$version.linux-amd64.tar.gz
url=https://go.dev/dl/$tarball
log "INFO" "Downloading Go $version: $tarball - $url"
curl -L -o /tmp/$tarball $url

log "INFO" "Installing Go"
sudo rm -rf /usr/local/go && tar -C /usr/local -xzf /tmp/$tarball

export PATH="/usr/local/go/bin:$PATH"

sudo -u r3d5un env PATH="/usr/local/go/bin:$PATH" go install honnef.co/go/tools/cmd/staticcheck@latest
sudo -u r3d5un env PATH="/usr/local/go/bin:$PATH" go install -tags 'postgres,sqlserver,mysql,mariadb' github.com/golang-migrate/migrate/v4/cmd/migrate@latest
sudo -u r3d5un env PATH="/usr/local/go/bin:$PATH" go install github.com/segmentio/golines@latest
sudo -u r3d5un env PATH="/usr/local/go/bin:$PATH" go install github.com/air-verse/air@latest
sudo -u r3d5un env PATH="/usr/local/go/bin:$PATH" go install github.com/swaggo/swag/cmd/swag@latest
sudo -u r3d5un env PATH="/usr/local/go/bin:$PATH" go install golang.org/x/tools/go/analysis/passes/fieldalignment/cmd/fieldalignment@latest
sudo -u r3d5un env PATH="/usr/local/go/bin:$PATH" go install google.golang.org/protobuf/cmd/protoc-gen-go@latest

log "INFO" "Stowing IdeaVim configuration"
stow --verbose -d "$cwd/dotfiles" -t /home/r3d5un/ ideavim

log "INFO" "Setting up Neovim"
snap install nvim --classic
sudo -u r3d5un mkdir -p /home/r3d5un/.config/nvim
stow --verbose -d "$cwd/dotfiles" -t /home/r3d5un/.config/nvim/ nvim

log "INFO" "Setting up NVM"
sudo -u r3d5un curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | sudo -u r3d5un bash

log "INFO" "Setting up Password Store"
sudo apt install -y \
	gnupg2 \
	pass

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

log "INFO" "Setting up Steam"
sudo apt install -y steam-installer

log "INFO" "Setting up Kubernetes"
sudo snap install microk8s --classic

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

log "INFO" "Installing Neovim dependencies"
sudo snap install julia --classic

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

