#!/bin/bash

set -e

# Variables

GREEN='\033[0;32m'
NC='\033[0m'

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/config"
CONFIG_DIR="$HOME/.config"
BASHRC=$HOME/.bashrc

# Functions

link_config() {
    local src="$1"
	local dest="$2"

	echo "Linking $src -> $dest"

	mkdir -p "$(dirname "$dest")"
	ln -sfn "$src" "$dest"
}

backup() {
	if [ -e "$1" ] && [ ! -L "$1" ]; then
		cp -r "$1" "$1.bak.$(date +%s)"
		rm -R "$1"
	fi
}

# Add theme module
echo "Adding theme module..."

link_config \
	"$ROOT_DIR/theme" \
	"$CONFIG_DIR/"

config/theme/generate.sh MagentaDark

echo -e "${GREEN}Theme MagentaDark generated${NC}"

# Kitty config
echo "Configuring kitty..."

backup "$CONFIG_DIR/kitty"

link_config \
	"$ROOT_DIR/kitty" \
	"$CONFIG_DIR/"

echo -e "${GRE}Kitty configured${NC}"

# Fastfetch config
echo "Configuring fastfetch..."

backup "$CONFIG_DIR/fastfetch"

link_config \
	"$ROOT_DIR/fastfetch" \
	"$CONFIG_DIR/"

echo -e "${GRE}Fastfetch configured${NC}"

# Starship
echo "Configuring starship..."

backup "$CONFIG_DIR/starship.toml"

link_config \
	"$ROOT_DIR/starship.toml" \
	"$CONFIG_DIR/"

if ! grep -qF 'eval "$(starship init bash)"' "${BASHRC}" ; then
    echo 'eval "$(starship init bash)"' >> "${BASHRC}"
fi

echo -e "${GRE}Starship configured${NC}"

# Hyprland
echo "Configuring hyprland..."

backup "$CONFIG_DIR/hypr"

link_config \
	"$ROOT_DIR/hypr" \
	"$CONFIG_DIR/"

echo -e "${GRE}Hyprland configured${NC}"

# Quickshell
echo "Configuring Quickshell..."

backup "$CONFIG_DIR/quickshell"

link_config \
	"$ROOT_DIR/quickshell" \
	"$CONFIG_DIR"

echo -e "${GRE}Quickshell configured${NC}"

# Configuracion de Bash

if ! grep -qF 'export VISUAL' "${BASHRC}" ; then
    echo 'export VISUAL=code' >> "${BASHRC}"
fi

if ! grep -qF 'export EDITOR' "${BASHRC}" ; then
    echo 'export EDITOR=nvim' >> "${BASHRC}"
fi

if ! grep -qF 'eval "$(ssh-agent -s)"' "${BASHRC}" ; then
	echo 'eval "$(ssh-agent -s)"' >> "${BASHRC}"
fi

if ! grep -qF 'ssh-add ~/.ssh/github_rsa' "${BASHRC}" ; then
	echo 'ssh-add ~/.ssh/github_rsa' >> "${BASHRC}"
fi

if ! grep -qF "alias ls='eza" "${BASHRC}" ; then
    echo "alias ls='eza -g --group-directories-first --icons -a -w 80 --sort=name'" >> "${BASHRC}"
fi

if ! grep -qF "fastfetch" "${BASHRC}" ; then
    echo "fastfetch --kitty-icat ~/.config/fastfetch/neco-arc.gif" >> "${BASHRC}"
fi

# Check dir

echo -e "${ROOT_DIR}"