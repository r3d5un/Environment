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
