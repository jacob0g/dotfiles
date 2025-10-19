#!/bin/zsh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# Zsh Widgets
autoload -Uz compinit promptinit
compinit
promptinit
eval "$(register-python-argcomplete pipx)"

# Prompt Theme
prompt walters

# SSH Keys in ~/.ssh/...
ssh_keys=("github" "gitlab" "bitbucket")

# Enable colors
export TERM="xterm-256color"

# Aliases
alias sudo='sudo '
alias vim='nvim'
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Setup dotfiles
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
config config --local status.showUntrackedFiles no

# Start SSH Agent
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" > /dev/null

    # Add SSH Keys
    for key in "${ssh_keys[@]}"; do
        ssh-add ~/.ssh/$key > /dev/null
    done
fi



# Created by `pipx` on 2025-10-16 07:50:04
export PATH="$PATH:/home/mac/.local/bin"
