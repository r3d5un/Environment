#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "Error: root required, use 'sudo $0'." >&2
	exit 1
fi

