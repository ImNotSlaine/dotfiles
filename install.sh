#!/bin/bash
# This script installs all the programs and sets the config files in the current directory, used in the github.com/ImNotSlaine/dotfiles.git.

# Uncomment to install the needed packages
# sudo pacman -S qtile picom feh kitty

# Creates a link form the config files in this directory to the original ~/.config/ directory
ln -f .config/kitty/kitty.conf ~/.config/kitty/kitty.conf

exit
