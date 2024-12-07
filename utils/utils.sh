#!/bin/bash

# log logs messages with a timestamp, level and message
log() {
	local level="$1"
	local message="$2"
	timestamp=$(date '+%Y-%m-%d %H:%M:%S')
	if [[ $dry_run == "1" ]]; then
		echo "[DRY_RUN] [$timestamp] [$level] $message"
	else
		echo "[$timestamp] [$level] $message"
	fi
}

# require_root checks if the script is running with root priveleges.
# If root privileges are not found the function exits with code 1
# and an error message
require_root() {
	if [[ $EUID -ne 0 ]]; then
		log "ERROR" "This script requires root permissions. Use sudo."
		exit 1
	fi
}
