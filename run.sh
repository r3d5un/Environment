#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "Error: root required, use 'sudo $0'." >&2
	exit 1
fi

cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
dry_run="0"

while [[ $# -gt 0 ]]; do
	case "$1" in
	--dry)
		run_run="1"
		;;
	--help)
		echo "Usage: $0 [--dry]"
		echo "Description: This script updates the system and requires root privileges."
		exit 0
		;;
	*)
		echo "Unknown argument: $1" >$2
		exit 1
		;;
	esac
	echo "ARG: \"$1\""
	if [[ "$1" == "--dry" ]]; then
		dry_run="1"
		shift
	fi
done

log() {
	if [[ $dry_run == "1" ]]; then
		echo "[DRY_RUN]: $1"
	else
		echo "$1"
	fi
}

