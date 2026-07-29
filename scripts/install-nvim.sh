#!/bin/bash
cd "$HOME" || exit 1

ARCH=$(uname -m)

case "$ARCH" in
x86_64)
    NVIM_ARCH="x86_64"
    ;;
aarch64 | arm64)
    NVIM_ARCH="arm64"
    ;;
*)
    echo "Unsupported architecture: $ARCH"
    exit 1
    ;;
esac

NVIM_TAR="nvim-linux-$NVIM_ARCH.tar.gz"

rm -rf "$HOME/.local/share/nvim"
mkdir -p "$HOME/.local/bin" "$HOME/.local/share"

curl -LO "https://github.com/neovim/neovim/releases/latest/download/$NVIM_TAR"
tar -xzf "$NVIM_TAR"
mv "nvim-linux-$NVIM_ARCH" "$HOME/.local/share/nvim"
ln -sf "$HOME/.local/share/nvim/bin/nvim" "$HOME/.local/bin/nvim"
rm -rf "$NVIM_TAR"

cd "$HOME/dotfiles" || exit 1
bash "$HOME/dotfiles/scripts/update-nvim-config.sh"
