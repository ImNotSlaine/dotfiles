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
sudo pacman -S --noprogressbar --noconfirm --needed kitty qtile feh picom ttf-mononoki-nerd fastfetch rofi starship
echo -e "${GREEN}All packages installed!${NC}"

# Configuration
echo "Copying configuration files from the repository..."
ln -f ./.config/qtile/config.py ~/.config/qtile/config.py
echo -e "${GREEN}qtile configured...${NC}"
ln -f ./.config/kitty/kitty.conf ~/.config/kitty/kitty.conf
echo -e "${GREEN}kitty configured...${NC}"
if ls ~/.config | grep -q picom; then
        echo "~/.config/picom directory already created"
else
        mkdir ~/.config/picom
        echo "Created picom directory in ~/.config/"
fi
ln -f ./.config/picom/picom.conf ~/.config/picom/picom.conf
echo -e "${GREEN}picom configured...${NC}"
ln -f ./.config/starship.toml ~/.config/starship.toml
echo -e "${GREEN}starship configured...${NC}"

# Reboot if wanted
echo -e "${GREEN}NeoNPunk installed successfully${NC}"
echo "A reboot is recomended for some configurations to take effect"
echo -e "Thanks for installing NeoNPunk dotfiles! Have fun\nIf you have any problems or recommendations, create an issue in https://github.com/ImNotSlaine/dotfiles"
