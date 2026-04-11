# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

. /etc/profile.d/wezterm.sh

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

export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

sdku() {
    if [ -z $1 ]; then
        echo "No version specified. Usage: sdku <VERSION>"
        exit 1
    fi
    local version=$(sdk list java | rg installed | rg " $1" | awk '{print $NF}' | head -n 1)
    if [ -n "$version" ]; then
        sdk use java "$version"
    else
        echo "No installed java version found matching: $1"
    fi
}

# aliases
alias tma="tmux new-session -A -s main"
alias vim="nvim"
alias sdkl="sdk list java | rg installed"
alias copy="wl-copy"

alias ll="ls -l"
alias la="ls -la"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
