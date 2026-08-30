#!/bin/bash
cd "$HOME" || exit 1

FZF_VERSION="0.74.3"
RG_VERSION="15.2.0"

OS=$(uname -s)
ARCH=$(uname -m)

if [ "$OS" = "Darwin" ]; then
    NVIM_OS="macos"
    if [ "$ARCH" = "x86_64" ]; then
        NVIM_ARCH="x86_64"
        FZF_FILE="fzf-${FZF_VERSION}-darwin_amd64.zip"
        RG_FILE="ripgrep-${RG_VERSION}-x86_64-apple-darwin.tar.gz"
    elif [ "$ARCH" = "arm64" ] || [ "$ARCH" = "aarch64" ]; then
        NVIM_ARCH="arm64"
        FZF_FILE="fzf-${FZF_VERSION}-darwin_arm64.zip"
        RG_FILE="ripgrep-${RG_VERSION}-aarch64-apple-darwin.tar.gz"
    fi
elif [ "$OS" = "Linux" ]; then
    NVIM_OS="linux"
    if [ "$ARCH" = "x86_64" ]; then
        NVIM_ARCH="x86_64"
        FZF_FILE="fzf-${FZF_VERSION}-linux_amd64.tar.gz"
        RG_FILE="ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl.tar.gz"
    elif [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
        NVIM_ARCH="arm64"
        FZF_FILE="fzf-${FZF_VERSION}-linux_arm64.tar.gz"
        RG_FILE="ripgrep-${RG_VERSION}-aarch64-unknown-linux-gnu.tar.gz"
    fi
else
    echo "Unsupported OS: $OS"
    exit 1
fi

mkdir -p "$HOME/.local/bin" "$HOME/.local/share"
TMP_DIR=$(mktemp -d)

echo ">>> Installing Neovim..."
NVIM_TAR="nvim-${NVIM_OS}-${NVIM_ARCH}.tar.gz"
rm -rf "$HOME/.local/share/nvim"
curl -L -o "$TMP_DIR/$NVIM_TAR" "https://github.com/neovim/neovim/releases/latest/download/$NVIM_TAR"
tar -xzf "$TMP_DIR/$NVIM_TAR" -C "$TMP_DIR"
mv "$TMP_DIR/nvim-${NVIM_OS}-${NVIM_ARCH}" "$HOME/.local/share/nvim"
ln -sf "$HOME/.local/share/nvim/bin/nvim" "$HOME/.local/bin/nvim"

echo ">>> Installing fzf (Dependency for fzf-lua)..."
curl -L -o "$TMP_DIR/$FZF_FILE" "https://github.com/junegunn/fzf/releases/download/v${FZF_VERSION}/${FZF_FILE}"
if [[ "$FZF_FILE" == *.zip ]]; then
    unzip -q "$TMP_DIR/$FZF_FILE" -d "$TMP_DIR"
else
    tar -xzf "$TMP_DIR/$FZF_FILE" -C "$TMP_DIR"
fi
mv "$TMP_DIR/fzf" "$HOME/.local/bin/fzf"
chmod +x "$HOME/.local/bin/fzf"

echo ">>> Installing ripgrep (Dependency for fzf-lua)..."
curl -L -o "$TMP_DIR/$RG_FILE" "https://github.com/BurntSushi/ripgrep/releases/download/${RG_VERSION}/${RG_FILE}"
tar -xzf "$TMP_DIR/$RG_FILE" -C "$TMP_DIR"
# Ripgrep extracts into a subfolder, we need to find the binary
find "$TMP_DIR" -type f -name "rg" -exec mv {} "$HOME/.local/bin/rg" \;
chmod +x "$HOME/.local/bin/rg"

rm -rf "$TMP_DIR"
echo ">>> Installation complete. Binaries are in ~/.local/bin"

cd "$HOME/dotfiles" || exit 1
bash "$HOME/dotfiles/scripts/update-nvim-config.sh"
