# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
	PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi
unset rc

export EDITOR=nvim
export VISUAL=nvim

# Go
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:"$HOME/go/bin:$PATH"

# Added by Toolbox App
export PATH="$PATH:/home/r3d5un/.local/share/JetBrains/Toolbox/scripts"

# Poetry
# curl -sSL https://install.python-poetry.org | python3 -

# Rust
. "$HOME/.cargo/env"

# SSH Tunnel
alias natsuki-tunnel="ssh natsuki -L 127.0.0.1:22001:127.0.0.1:22000 -R 127.0.0.1:22001:127.0.0.1:22000"
alias amaterasu-tunnel="ssh amaterasu -L 127.0.0.1:22001:127.0.0.1:22000 -R 127.0.0.1:22001:127.0.0.1:22000"
alias amaterasu-syncthing="ssh r3d5un@amaterasu -L 18384:localhost:8384"

# Sync Airflow DAGs
alias sync-dags='rsync -av --delete --exclude "*__pycache__" /home/r3d5un/Development/Projects/Airflow/DAGs/ /home/r3d5un/Cluster/airflow-airflow-dags-pvc-pvc-b6f2bfbf-23d8-4e36-abc8-1af5440fbf48/'

# Development Server Directory Sync
alias sync-rp='rsync -urltv --delete -e ssh Development/Projects/rd-regnskapsportal/. okristiansen@dfo-tu-dev02:/home/okristiansen/Projects/Regnskapsportal/'
alias sync-airflow='rsync -urltv --delete -e ssh Development/Projects/RD-Airflow/. okristiansen@dfo-tu-dev02:/home/okristiansen/Projects/Airflow/'
alias sync-datahub='rsync -urltv --delete -e ssh Development/Projects/DatahubApiGo/. okristiansen@dfo-tu-dev02:/home/okristiansen/Projects/Datahub/'

# Load Restic secrets as environment variables from the password-store
alias load-restic="source $HOME/Environment/profiles/restic.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  tmux attach-session -t default || tmux new-session -s default
fi
