#!/bin/bash

cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$cwd/../utils/utils.sh"

echo_banner "#C/.NET"

log "INFO" ".NET install process not implemented"

# TODO: The official .NET SDK requires libopenssl1_0_0, which is not provided in the OpenSUSE repositories.
# An alternative route is to use distrobox.

# require_root
#
# log "INFO" "Installing dependencies"
# sudo zypper --non-interacive install libicu
#
# log "INFO" "Installing Microsoft repository"
# sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
# wget https://packages.microsoft.com/config/opensuse/15/prod.repo
# sudo mv prod.repo /etc/zypp/repos.d/microsoft-prod.repo
# sudo chown root:root /etc/zypp/repos.d/microsoft-prod.repo
#
# log "INFO" "Installing .NET SDK and ASP.NET Core Runtime"
# sudo zypper --non-interactive \
# 	install dotnet-sdk-9.0 \
# 	aspnetcore-runtime-9.0
#
