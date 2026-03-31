#!/bin/zsh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# Zsh Widgets
autoload -Uz compinit 
compinit
eval "$(register-python-argcomplete pipx)"

# -- User Configuration --

# SSH Keys in ~/.ssh/...
ssh_keys=("github" "gitlab" "bitbucket")

# Enable colors
export TERM="xterm-256color"

# Aliases
alias sudo='sudo '
alias vim='nvim'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias wine='env -u DISPLAY wine' # use wayland
alias winecfg='env -u DISPLAY winecfg'

# Setup dotfiles
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
config config --local status.showUntrackedFiles no

# Start SSH Agent
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" > /dev/null

    # Add SSH Keys
    for key in "${ssh_keys[@]}"; do
        # Check key exists
        if [ -f "$HOME/.ssh/$key" ]; then
            ssh-add $HOME/.ssh/$key 2> /dev/null
        fi
    done
fi

# Bind Ctrl+Arrow Keys for navigation
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Fix delete key
bindkey "^[[3~" delete-char

# Fix home/end keys if necessary
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

# Add pipx path
export PATH="$PATH:$HOME/.local/bin"

export PATH="$PATH:$HOME/can-utils"

export PATH="$PATH:/opt/ozone"
export PATH="$PATH:/opt/JLink"
export PATH="$PATH:/opt/renode/bin"
export PATH="$PATH:$HOME/.dotnet/tools"
export PATH="$PATH:$HOME/.local/ti-cgt-tms470/bin"
export PATH="$PATH:$HOME/.platformio/penv/bin"
export PATH="$PATH:/opt/vesc-tool"

export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"
# export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/opt/JLink"
