#!/bin/bash

cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$cwd/../utils/utils.sh"

echo_banner "#C/.NET"

require_root

sudo dnf install -y \
	dotnet-sdk-9.0 \
	aspnetcore-runtime-9.0
