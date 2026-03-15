#!/bin/bash
# Stops the script if something fails
set -e

# Variables
RED='\033[0;31m'
GREEN='\033[0;32m'
MGT='\033[0;35m'
NC='\033[0m'

# Introduction and warnings
echo -e "Welcome to the ${MGT}TokyoNeon${NC} installation script" && sleep 1
echo -e "${RED}This script requires sudo ${NC}in some parts, so keep an eye on the terminal" && sleep 1

# System upgrade
read -n 1 -p 'Do you want to fully upgrade the system? (y/n): ' upgrade
echo
if [ "$upgrade" = "y" ]; then
	sudo pacman --noconfirm --noprogressbar -Syu
	echo -e "${GREEN}System updated${NC}"
else
	echo "The system won't upgrade"
fi

# Paru install
if ! pacman -Q | grep -q -e 'paru ' ; then
	read -n 1 -p 'Paru is needed for some packages, install it? (y/n): ' paru
	echo
	if [ "$paru" = "y" ]; then
		sudo pacman -S --neeeded base-devel
		git clone https://aur.archlinux.org/paru.git
		cd paru
		makepkg -si
		echo "Paru installed"
	else
		echo "Please install paru manually"
		exit 1
	fi
fi

# Packages install
echo "Install the needed packages..."
	# Pacman pkgs
sudo pacman -S --noprogressbar --noconfirm --needed \
	jq \
	hyprland \
	kitty \
	starship \
	ttf-mononoki-nerd \
	fastfetch \
	dart-sass
	
	# Paru pkgs
paru -S \
	aylurs-gtk-shell \
	--noconfirm --noprogressbar --needed
echo -e "${GREEN}Packages installed${NC}"

# Create backup .config
# cp -r ~/.config ~/.config.bak
# Configuration for hyperland plugins
if hyprpm list | grep -q "hyprland-plugins"; then
	echo -e "hyprland-plugins repository already cloned"
else
	hyprpm add https://github.com/hyprwm/hyprland-plugins
fi
hyprpm enable borders-plus-plus

# Reboot if wanted
echo -e "${GREEN}TokyoNeon installed successfully${NC}"
echo "A reboot is recomended for some configurations to take effect"
echo -e "Thanks for installing TokyoNeon dotfiles! Have fun\nIf you have any problems or recommendations, create an issue in https://github.com/ImNotSlaine/dotfiles"
