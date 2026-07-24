#!/bin/bash

git pull
rm -rf "$HOME/.config/nvim"
cp -r "$HOME/dotfiles/.config/nvim" "$HOME/.config"
