#!/bin/bash

version="1.23.4"

cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$cwd/../utils/utils.sh"

echo_banner "GO"

require_root

# https://go.dev/dl/go1.22.10.linux-amd64.tar.gz
tarball=go$version.linux-amd64.tar.gz
url=https://go.dev/dl/$tarball
log "INFO" "Downloading Go $version: $tarball - $url"
curl -L -o /tmp/$tarball $url

log "INFO" "Installing Go"
sudo rm -rf /usr/local/go && tar -C /usr/local -xzf /tmp/$tarball

# rm $tarball

# The PATH is set in .bashrc, but path is set here to guarantee any further dependencies on the Go tooling
log "INFO" "Updating PATH"
export PATH="/usr/local/go/bin:$PATH"

log "INFO" "Updating tooling"

log "INFO" "Installing staticcheck"
go install honnef.co/go/tools/cmd/staticcheck@latest

log "INFO" "Installing golang-migrate"
go install -tags 'postgres,sqlserver,mysql,mariadb' github.com/golang-migrate/migrate/v4/cmd/migrate@latest

log "INFO" "Installing golines"
go install github.com/segmentio/golines@latest

log "INFO" "Installing air"
go install github.com/air-verse/air@latest

log "INFO" "Installing swaggo"
go install github.com/swaggo/swag/cmd/swag@latest

log "INFO" "Installing fieldalignment"
go install golang.org/x/tools/go/analysis/passes/fieldalignment/cmd/fieldalignment@latest
