#!/bin/bash

set -e

# Variables
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/config"
CONFIG_DIR="$HOME/.config"

DEF_THEME="$(awk '/name/ {print $3}' "$CONFIG_DIR/kitty/_colors.conf")"

RED='\033[0;31m'
GRE='\033[0;32m'
MGT='\033[0;35m'
NC='\033[0m'

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

echo -e "Welcome to the ${MGT}TokyoNeon${NC} installation script" && sleep 1
echo -e "${RED}This script requires sudo ${NC}in some parts, so keep an eye on the terminal" && sleep 1

# Ask upgrade
read -n 1 -p 'Do you want to fully upgrade the system? (y/n)' upgrade

if [ '$upgrade' = 'y' ]; then
	sudo pacman -Syu --noconfirm --noprogressbar
	echo -e "${GREEN}System upgraded${NC}"
else
	echo "The system won't upgrade"
fi

# Install paru
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
fi

# Install dependencies
echo "Installing dependencies..."

sudo pacman -S --noprogressbar --noconfirm --needed \
	jq \
	ttf-mononoki-nerd \
	hyprland \
	kitty \
	starship \
	fastfetch \
	dart-sass

echo -e "${GRE}Dependencies from pacman installed${NC}"

paru -S \
	quickshell-git \
	--noprogressbar --noconfirm --needed

echo -e "${GRE}Dependencies from AUR installed${NC}"

# Theme
echo "Configuring theme..."

backup "$CONFIG_DIR/theme"

link_config \
	"$ROOT_DIR/theme" \
	"$CONFIG_DIR/"

echo -e "${GRE}Theme configured${NC}"

echo -e "Using ${MGT}$DEF_THEME ${NC}theme"

# Hyprland
echo "Configuring hyprland..."

backup "$CONFIG_DIR/hypr"

link_config \
	"$ROOT_DIR/hypr" \
	"$CONFIG_DIR/"

echo -e "${GRE}Hyprland configured${NC}"

# Hyprland Plugin
if hyprpm list | grep -q "hyprland-plugins"; then
	echo -e "hyprland-plugins repository already in use"
else
	hyprpm add https://github.com/hyprwm/hyprland-plugins
fi
hyprpm enable borders-plus-plus
hyprpm reload

# Kitty
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

# AGS
echo "Configuring Quickshell..."

backup "$CONFIG_DIR/quickshell"

link_config \
	"$ROOT_DIR/quickshell" \
	"$CONFIG_DIR"

echo -e "${GRE}Quickshell configured${NC}"

# End
echo -e "${MGT}TokyoNeon${GRE} installed successfully${NC}"

echo "A reboot is recomended for some configurations to take effect"

echo "Thanks for installing TokyoNeon dotfiles! Have fun"

echo "If you have any problems or recommendations, create an issue in https://github.com/ImNotSlaine/dotfiles"
