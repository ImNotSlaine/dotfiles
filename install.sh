#!/bin/bash

set -e

# Variables

GREEN='\033[0;32m'
NC='\033[0m'

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/config"
CONFIG_DIR="$HOME/.config"

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


# Check packages

echo -e "Checking for paru..."
if ! pacman -Q | grep -q -e 'paru ' ; then
	read -n 1 -p 'Paru is needed for some packages, install it? (y/n)' paru
	echo
	if [ "$paru" = "y" ]; then
		sudo pacman -S --noprogressbar --noconfirm --needed base-devel
		git clone -q https://aur.archlinux.org/paru.git
		cd paru
		makepkg -si
		echo -e "${GREEN}Paru installed${NC}"
		cd ..
	else
		echo "Please install paru manually"
		exit 1
	fi
else
    echo -e "${GREEN}Paru installed${NC}"
fi

echo -e "Checking for dependencies..."
paru -S --noconfirm --noprogressbar --needed \
    hyprland \
    ttf-mononoki-nerd \
    kitty \
    starship \
    fastfetch \
    jq \
    quickshell-git

echo -e "${GREEN}Dependencies installed${NC}"

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

# Starship
echo "Configuring starship..."

backup "$CONFIG_DIR/starship.toml"

link_config \
	"$ROOT_DIR/starship.toml" \
	"$CONFIG_DIR/"

echo -e "${GRE}Starship configured${NC}"

# Check dir

echo -e "${ROOT_DIR}"