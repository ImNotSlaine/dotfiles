#!/bin/bash
# Stops the script if something fails
set -e

# Variables
RED='\033[0;31m'
GREEN='\033[0;32m'
MGT='\033[0;35m'
NC='\033[0m'

# Introduction and warnings
echo -e "Welcome to the ${MGT}NeoNPunk${NC} installation script" && sleep 1
echo -e "${RED}This script requires sudo ${NC}in some parts, so keep an eye on the terminal" && sleep 1
echo -e "${RED}Some personal configurations may override${NC}, execute at your own risk!!!" && sleep 4

# System update
echo "First a full upgrade..."
sudo pacman --noconfirm --noprogressbar -Syu
echo -e "${GREEN}System updated succesfully :D${NC}"

# Needed packages
echo "Let's install the needed packages..."
sudo pacman -S --noprogressbar --noconfirm --needed hyprland hyprpaper cpio cmake git meson gcc waybar kitty ttf-mononoki-nerd fastfetch rofi starship
echo -e "${GREEN}All packages installed!${NC}"

# Configuration
echo "Copying configuration files from the repository..."
ln -f ./.config/kitty/kitty.conf ~/.config/kitty/kitty.conf
echo -e "${GREEN}kitty configured...${NC}"
ln -f ./.config/starship.toml ~/.config/starship.toml
echo -e "${GREEN}starship configured...${NC}"
cp -r ./.config/hypr/wallpapers ~/.config/hypr/wallpapers
ln -f ./.config/hypr/hyprpaper.conf ~/.config/hypr/hyprpaper.conf
echo -e "${GREEN}hyprpaper configured...${NC}"
ln -f ./.config/hypr/hyprland.conf ~/.config/hypr/hyprland.conf
# Configuration for hyperland plugins
if hyprpm list | grep -q "hyprland-plugins"; then
	echo -e "hyprland-plugins repository already cloned"
else
	hyprpm add https://github.com/hyprwm/hyprland-plugins
fi
hyprpm enable borders-plus-plus
echo -e "${GREEN}hyprland configured...${NC}"

# Reboot if wanted
echo -e "${GREEN}NeoNPunk installed successfully${NC}"
echo "A reboot is recomended for some configurations to take effect"
echo -e "Thanks for installing NeoNPunk dotfiles! Have fun\nIf you have any problems or recommendations, create an issue in https://github.com/ImNotSlaine/dotfiles"
