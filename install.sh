#!/bin/bash
# This script installs all the programs and sets the config files in the current directory, used in the github.com/ImNotSlaine/dotfiles.git.

echo 'Starting dotfiles installation...'

# Loop for installing packages
apps=("qtile" "picom" "feh" "kitty" "fish" "rofi" "fisher" "ttf-mononoki-nerd" "lightdm")
install=()

for app in "${apps[@]}"; do
	if pacman -Qs | grep -q -w "$app"; then
		echo "$app already installed"
	else
		echo "$app not installed"
		install+=$app
	fi
done

if (( ${#install[@]} > 0 )); then
	echo "Installing needed packages..."
	for needed in "${install[@]}"; do
		if sudo pacman -S "$needed"; then
			echo "$needed installed succesfully"
		else
			echo "Some error has occurred, install $needed manually."
		fi
	done
fi

# Configure qtile
ln -f ./.config/qtile/config.py ~/.config/qtile/config.py

# Configure kitty
ln -f ./.config/kitty/kitty.conf ~/.config/kitty/kitty.conf

# Configure fish
ln -f ./.config/fish/config.fish ~/.config/fish/config.fish

# Cofigure picom
if ls ~/.config | grep -q picom; then
	echo "~/.config/picom directory already created"
else
	mkdir ~/.config/picom
	echo "Created picom directory in ~/.config/"
fi
ln -f ./.config/picom/picom.conf ~/.config/picom/picom.conf

echo 'Installation finished :3'
echo "Enjoy this setup, for information on keybindings and extensive configuration of qtile see the README.md file in .config/qtile"
exit
