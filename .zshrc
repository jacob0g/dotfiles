# -- Environment --

typeset -U path   # keep PATH free of duplicates
path+=(
    $HOME/.local/bin          # pipx
    $HOME/can-utils
    /opt/ozone
    /opt/JLink
    /opt/renode/bin
    $HOME/.dotnet/tools
    $HOME/.local/ti-cgt-tms470/bin
    $HOME/.platformio/penv/bin
    /opt/vesc-tool
    /opt/c2prog
    # $HOME/ti/ccs2051/ccs/theia
)

[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

path=($^path(N-/))   # drop directories that don't exist

# Only add the separator if LD_LIBRARY_PATH is already set: a leading ':'
# would add the current directory to the library search path
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}/usr/local/lib"
# export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/opt/JLink"

[[ -f ~/.config/secrets.env ]] && source ~/.config/secrets.env

# -- Oh My Zsh --

export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="/usr/share/zsh"

# Install if missing
if [[ ! -f "$ZSH/oh-my-zsh.sh" ]]; then
    git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$ZSH"
fi

ZSH_THEME="robbyrussell"
CASE_SENSITIVE="true"

# ssh-agent plugin: load every private key in ~/.ssh that has a matching .pub
# (these zstyles must be set before Oh My Zsh is sourced)
ssh_keys=()
for p in ~/.ssh/*.pub(N); do
    [[ -f "${p%.pub}" ]] && ssh_keys+=("${p%.pub}")
done
unset p
zstyle :omz:plugins:ssh-agent honor-existing yes
zstyle :omz:plugins:ssh-agent identities $ssh_keys

plugins=(
    git
    ssh-agent
    python
    zsh-autosuggestions
    zsh-syntax-highlighting   # must be last
)
source "$ZSH/oh-my-zsh.sh"

# -- Aliases --

alias sudo='sudo '   # let aliases work after sudo
alias vim='nvim'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias wine='env -u DISPLAY wine'        # use Wayland
alias winecfg='env -u DISPLAY winecfg'

# Dotfiles (bare repo)
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

# -- Key bindings --

bindkey '^[[Z'    autosuggest-accept    # Shift+Tab: accept suggestion
bindkey '^[[1;5C' forward-word          # Ctrl+Right
bindkey '^[[1;5D' backward-word         # Ctrl+Left
bindkey '^[[3~'   delete-char           # Delete
bindkey '^[[H'    beginning-of-line     # Home
bindkey '^[[F'    end-of-line           # End
