#!/bin/zsh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# Zsh Widgets
autoload -Uz compinit promptinit
compinit
promptinit

# Prompt Theme
prompt walters

# Enable colors
export TERM="xterm-256color"

# Aliases
alias vim='nvim'
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Setup dotfiles
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
config config --local status.showUntrackedFiles no

# Start SSH Agent
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" > /dev/null
    ssh-add ~/.ssh/github > /dev/null
fi


