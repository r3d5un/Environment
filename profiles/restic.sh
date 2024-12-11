#!/bin/bash

export AWS_ACCESS_KEY_ID=$(pass digitalocean/restic/access_key_id | head -1)
export AWS_SECRET_ACCESS_KEY=$(pass digitalocean/restic/access_key | head -1)
export RESTIC_REPOSITORY=$(pass digitalocean/restic/repository | head -1)
export RESTIC_PASSWORD=$(pass digitalocean/restic/password | head -1)
export RESTIC_COMPRESSION="max"
export RESTIC_PACK_SIZE="128"
