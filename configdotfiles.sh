#!/bin/bash
set -e

echo -e "Welcome to the configuration script of NeoNPunk dotfiles"
echo -e "This script will only create folders and symlinks in your .config dir to allow the packages installed to use this config files"

ln -f ./.config/kitty/kitty.conf ~/.config/kitty/kitty.conf
ln -f ./.config/starship.toml ~/.config/starship.toml

cp -r ./.config/hypr/wallpapers ~/.config/hypr/wallpapers
ln -f ./.config/hypr/hyprpaper.conf ~/.config/hypr/hyprpaper.conf
ln -f ./.config/hypr/hyprland.conf ~/.config/hypr/hyprland.conf
if hyprpm list | grep -q "hyprland-plugins"; then
	echo -e "hyprland-plugins repository already cloned"
else
	hyprpm add https://github.com/hyprwm/hyprland-plugins
fi
hyprpm enable borders-plus-plus
