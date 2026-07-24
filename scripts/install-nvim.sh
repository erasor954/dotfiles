#!/bin/bash
cd "$HOME" || exit 1
rm -rf "$HOME/.local/share/nvim"
mkdir -p "$HOME/.local/bin" "$HOME/.local/share"
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
tar -xzf nvim-linux-x86_64.tar.gz
mv nvim-linux-x86_64 "$HOME/.local/share/nvim"
ln -sf "$HOME/.local/share/nvim/bin/nvim" "$HOME/.local/bin/nvim"
rm -rf nvim-linux-x86_64.tar.gz
cd "$HOME/dotfiles" || exit 1
bash "$HOME/dotfiles/scripts/update-nvim-config.sh"
