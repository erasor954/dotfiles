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


eval "$(fzf --bash)"
# EXPORT
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PS1="\u@\h:\w\$ "

# ALIAS
alias tma="tmux new-session -A -s main"
alias vi="nvim"
alias vim="nvim"
alias sdkl="sdk list java | rg installed"
alias copy="wl-copy"

alias ll="ls -l"
alias la="ls -la"

alias inv='nvim $(fzf -m --preview="bat -n --color=always {}")'

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

fcd() {
  local file
  # file=$(fzf --height 40%)
  file=$(fzf -m --preview='bat -n --color=always {}')
  if [ -n "$file" ]; then
    cd "$(dirname "$file")"
  fi
}


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

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
