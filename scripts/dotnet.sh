#!/bin/bash

cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$cwd/../utils/utils.sh"

echo_banner "#C/.NET"

require_root

# NOTE: The official .NET SDK requires libopenssl1_0_0, which is not provided in the OpenSUSE repositories. \
# A Distrobox setup based on Fedora is used as an alternative.

log "INFO" "Installing Distrobox dependency"
sudo zypper install \
	podman \
	distrobox

log "INFO" "Creating dotnet distrobox container"
sudo -u r3d5un distrobox create \
	--name dotnet \
	--image fedora:latest \
	--additional-packages "java-latest-openjdk-devel.x86_64 dotnet-sdk-9.0 git"

log "INFO" "Updating container packages"
sudo -u r3d5un distrobox enter dotnet -- sudo dnf update -y

log "INFO" "Running dotnet CLI to verify install"
sudo -u r3d5un distrobox enter dotnet -- dotnet --info
