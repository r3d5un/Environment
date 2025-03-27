#!/bin/bash

cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$cwd/utils/utils.sh"

require_root

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


if ! zypper lr | grep -q 'packman-essentials'; then
	log "INFO" "Adding Packman repository"
    sudo zypper ar -cfp 90 'https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/Essentials/' packman-essentials
fi

log "INFO" "Updating system"
if [[ $dry_run == "0" ]]; then
	sudo zypper dup --from packman-essentials --allow-vendor-change
	sudo zypper dup
fi

scripts=$(find $cwd/scripts -mindepth 1 -maxdepth 1 -executable | sort)
for script in $scripts; do
	log "INFO" "Running script: $script"

	if [[ $dry_run == "0" ]]; then
		$script
	fi
done

log "INFO" "Done. Reboot required for all changes to take effect."

