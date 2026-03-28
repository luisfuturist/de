#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

source /usr/local/aliases/git.sh
source /usr/local/aliases/terraform.sh
source /usr/local/aliases/docker.sh
source /usr/local/aliases/utils.sh
alias opera="opera --private"

export EDITOR='cursor'
export REACT_EDITOR='cursor'

# pnpm
export PNPM_HOME="/home/luis/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
source /usr/local/aliases/git.sh

# ruby
export PATH="$PATH:$(gem env path | sed 's#[^:]\+#&/bin#g')"

. "$HOME/.local/bin/env"

# Use a disk-based temporary directory to avoid RAM issues.
export TMPDIR="${HOME}/tmp"
mkdir -p "${TMPDIR}"
. "/home/luis/.deno/env"
source /home/luis/.local/share/bash-completion/completions/deno.bash
# opencode
export PATH=/home/luis/.opencode/bin:$PATH

export PATH=/home/luis/bin:$PATH

[[ -e "/home/luis/lib/oracle-cli/lib/python3.14/site-packages/oci_cli/bin/oci_autocomplete.sh" ]] && source "/home/luis/lib/oracle-cli/lib/python3.14/site-packages/oci_cli/bin/oci_autocomplete.sh"

alias ssd='sudo systemctl start docker'
alias sdd='sudo systemctl stop docker'
alias srd='sudo systemctl restart docker'

# Vite+ bin (https://viteplus.dev)
. "$HOME/.vite-plus/env"
