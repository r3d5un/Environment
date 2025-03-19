# Sample .bashrc for SUSE Linux
# Copyright (c) SUSE Software Solutions Germany GmbH

# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc; in our setup, /etc/profile sources ~/.bashrc - thus all
# settings made here will also take effect in a login shell.
#
# NOTE: It is recommended to make language settings in ~/.profile rather than
# here, since multilingual X sessions would not work properly if LANG is over-
# ridden in every subshell.

test -s ~/.alias && . ~/.alias || true

export EDITOR=nvim
export VISUAL=nvim

# Go
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:"$HOME/go/bin:$PATH"

# Zig
export PATH=$PATH:/usr/local/zig

# Added by Toolbox App
export PATH="$PATH:/home/r3d5un/.local/share/JetBrains/Toolbox/scripts"

# Poetry
# curl -sSL https://install.python-poetry.org | python3 -

# Rust
. "$HOME/.cargo/env"

# SSH Tunnel
alias amaterasu-tunnel="ssh amaterasu -L 127.0.0.1:22001:127.0.0.1:22000 -R 127.0.0.1:22001:127.0.0.1:22000"
alias amaterasu-syncthing="ssh r3d5un@amaterasu -L 18384:localhost:8384"

# Sync Airflow DAGs
alias sync-dags='rsync -av --delete --exclude "*__pycache__" /home/r3d5un/Development/Projects/Airflow/DAGs/ /home/r3d5un/Cluster/airflow-airflow-dags-pvc-pvc-b6f2bfbf-23d8-4e36-abc8-1af5440fbf48/'

# Development Server Directory Sync
alias sync-rp='rsync -urltv --delete -e ssh ~/Development/Projects/rd-regnskapsportal/. okristiansen@dfo-tu-dev02:/home/okristiansen/Projects/Regnskapsportal/'
alias sync-airflow='rsync -urltv --delete -e ssh ~/Development/Projects/RD-Airflow/. okristiansen@dfo-tu-dev02:/home/okristiansen/Projects/Airflow/'
alias sync-datahub='rsync -urltv --delete -e ssh ~/Development/Projects/DatahubApiGo/. okristiansen@dfo-tu-dev02:/home/okristiansen/Projects/Datahub/'
alias sync-legacy='rsync -urltv --delete -e ssh ~/Development/Projects/legacy-system-archival-processes/. okristiansen@dfo-tu-dev02:/home/okristiansen/Projects/Legacy/'

# Load Restic secrets as environment variables from the password-store
alias load-restic="source $HOME/Environment/profiles/restic.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
. "$HOME/.cargo/env"
