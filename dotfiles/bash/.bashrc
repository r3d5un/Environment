PROMPT_COMMAND='PS1_CMD1=$(git branch --show-current 2>/dev/null)'; PS1='\u@\h:\W (${PS1_CMD1}) > '

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

# Vim
alias vim="nvim"
alias vi="nvim"

# Sync Airflow DAGs
alias sync-dags='rsync -av --delete --exclude "*__pycache__" /home/r3d5un/Development/Projects/Airflow/DAGs/ /home/r3d5un/Cluster/airflow-airflow-dags-pvc-pvc-b6f2bfbf-23d8-4e36-abc8-1af5440fbf48/'

# Development Server Directory Sync
alias sync-rp='rsync -urltv --delete -e ssh ~/Development/Projects/rd-regnskapsportal/. okristiansen@dfo-tu-dev02:/home/okristiansen/Projects/Regnskapsportal/'
alias sync-airflow='rsync -urltv --delete -e ssh ~/Development/Projects/RD-Airflow/. okristiansen@dfo-tu-dev02:/home/okristiansen/Projects/Airflow/'
alias sync-datahub='rsync -urltv --delete -e ssh ~/Development/Projects/DatahubApiGo/. okristiansen@dfo-tu-dev02:/home/okristiansen/Projects/Datahub/'
alias sync-legacy='rsync -urltv --delete -e ssh ~/Development/Projects/legacy-system-archival-processes/. okristiansen@dfo-tu-dev02:/home/okristiansen/Projects/Legacy/'

# Load Restic secrets as environment variables from the password-store
alias load-restic="source ~/Environment/profiles/restic.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

. "$HOME/.cargo/env"

# ls alterantive
alias ls='eza'

# Starship
eval "$(starship init bash)"

# Zoxide
eval "$(zoxide init --cmd cd bash)"

