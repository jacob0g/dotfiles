# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Plguins
plugins=(
    git
    python
    zsh-syntax-highlighting
    zsh-autosuggestions
)
source $ZSH/oh-my-zsh.sh

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

# Bind shift-tab to accept autosuggestion
bindkey '^[[Z' autosuggest-accept

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

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
