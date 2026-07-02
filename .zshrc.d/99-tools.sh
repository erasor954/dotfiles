# 99-tools.sh: External Tool Initialization

# Wezterm
if [ -f /etc/profile.d/wezterm.sh ]; then
    . /etc/profile.d/wezterm.sh
fi

# FZF
# eval "$(fzf --zsh)"

# /opt/homebrew/bin
eval "$(/opt/homebrew/bin/brew shellenv)"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# SDKMAN (MUST be at the end)
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
