#!/bin/bash

set -e

# Variables

GREEN='\033[0;32m'
NC='\033[0m'

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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
    quickshell-git

echo -e "${GREEN}Dependencies installed${NC}"

# Check dir

echo -e "${ROOT_DIR}"