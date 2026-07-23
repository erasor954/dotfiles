

autoload -Uz compinit && compinit
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

eval "$(/opt/homebrew/bin/brew shellenv)"

if [ -d ~/.zshrc.d ]; then
    for rc in ~/.zshrc.d/*; do
        if [ -f "$rc" ]; then
            source "$rc"
        fi
    done
fi
