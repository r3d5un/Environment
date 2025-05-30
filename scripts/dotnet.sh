#!/bin/bash

cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$cwd/../utils/utils.sh"

echo_banner "#C/.NET"

require_root

# NOTE: The official .NET SDK requires libopenssl1_0_0, which is not provided in the OpenSUSE repositories. \
# A Distrobox setup based on Fedora is used as an alternative.

log "INFO" "Installing the Microsoft package repository"
sudo zypper install libicu
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
wget https://packages.microsoft.com/config/opensuse/15/prod.repo
sudo mv prod.repo /etc/zypp/repos.d/microsoft-prod.repo
sudo chown root:root /etc/zypp/repos.d/microsoft-prod.repo

log "INFO" "Installing .NET SDK"
sudo zypper install dotnet-sdk-9.0

dotnet --info

