#!/bin/bash

cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$cwd/../utils/utils.sh"

echo_banner "PASS"

require_root

sudo zypper --non-interactive install \
	gnupg \
	password-store \
	git

# PGP keys will be required for the password store to work. The following
# commented lines show how to export you keys.
#
# Afterwards we will import it, then use it to setup and test the
# password store.
#
# 1. Exporting the public key as base64 encoded file named public.pgp:
# gpg --output public.pgp --armor --export email@address.com
#
# 2. Exporting the private key as base64 encoded file named private.pgp
# gpg --output private.pgp --armor --export-secret-key email@address.com
#
# 3. Enter private key password
#
# This script assumes that the keys are found in the secrets directory

# secrets_dir="$cwd/../secrets"
# log "INFO" "Checking for PGP keys in $secrets_dir"
# if [[ ! -e "$secrets_dir/public.pgp" || ! -e "$secrets_dir/private.pgp" ]]; then
# 	log "ERROR" "private or public key not found in $secrets_dir"
# 	exit 1
# else
# 	log "INFO" "Importing private PGP key"
# 	sudo -u r3d5un gpg --import $secrets_dir/private.pgp
#
# 	log "INFO" "Importing public PGP key"
# 	sudo -u r3d5un gpg --import $secrets_dir/public.pgp
# fi
#
# light_gray='\033[0m'
# no_color='\033[0m'
#
# echo -e "\n\nIn order for password store to work you need to trust the key\n"
# echo -e "Run: ${light_gray}gpg --edit-key email@address.io${no_color}\n"
# echo -e "Run the trust command, e.g.\n"
# echo -e "${light_gray}gpg> trust${no_color}\n"
# echo -e "Set trust level to the highest possible (5) when prompted:\n"
# echo -e "${light_gray}Your decision? 5${no_color}\n"
# echo -e "Quit and save:\n"
# echo -e "${light_gray}quit${no_color}\n\n"
#
# sudo -u r3d5un pass
#
