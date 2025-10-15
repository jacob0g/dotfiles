#
# ~/.bashrc
#

alias sudo='sudo '

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Enable colors
export TERM="xterm-256color"

# Aliases
alias vim='nvim'

# Setup dotfiles
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
config config --local status.showUntrackedFiles no

# Start SSH Agent
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" > /dev/null
    ssh-add ~/.ssh/git_work > /dev/null
fi


