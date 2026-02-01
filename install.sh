#!/bin/bash
# This script installs all the programs and sets the config files in the current directory, used in the github.com/ImNotSlaine/dotfiles.git.

echo 'Starting dotfiles installation...'

# Loop for installing main apps
apps=("qtile" "picom" "feh" "kitty" "fish")
install=()

for app in "${apps[@]}"; do
	if pacman -Qs | grep -q "$app"; then
		echo "$app already installed"
	else
		echo "$app not installed"
		install+=$app
	fi
done

if (( ${#install[@]} > 0 )); then
	echo "Installing needed packages..."
	sudo pacman -S ${install[@]}
fi

#Checking for fisher and tide
if pacman -Qs | grep -q fisher; then
	echo "fisher already installed"
else
	echo "fisher not installed"
	echo "Installing fisher..."
	curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
	echo "fisher succesfully installed!"
fi

if grep -q tide ~/.config/fish/fish_plugins; then
	echo "tide installed"
else
	echo "tide not installed"
	echo "Installing tide with fisher..."
	fisher install IlanCosman/tide@v6
	echo "tide succesfully installed"
fi

# Checks for installed fonts
if fc-list | grep -q MononokiNerd; then
	echo "MononokiNerdFont installed"
else
	if fc-list | grep -q Mononoki; then
		echo "Mononoki font installed, installing MononokiNerdFont as separate font..."
		wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Mononoki.tar.xz
		mkdir /usr/local/share/fonts/ttf/MononokiNerd
		sudo tar -xf Mononoki.tar.xz -C /usr/local/share/fonts/ttf/MononokiNerd/
		
	else
		echo "Mononoki not installed, installing MononokiNerdFont..."
		wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Mononoki.tar.xz
		mkdir /usr/local/share/fonts/ttf/Mononoki
		sudo tar -xf Mononoki.tar.xz -C /usr/local/share/fonts/ttf/Mononoki/
	fi
	echo "MononokiNerdFont succesfully installed!"
fi

# Checks if a greeter is installed
if pacman -Qs | grep -E -q 'lightdm|lxdm|sddm|xorg-xdm'; then
	echo "Greeter already installed, skipping..."
else
	echo "Installing lightdm and lightdm-gtk-greeter..."
	sudo pacman -S lightdm lightdm-gtk-greeter
	echo "lightdm succesfully installed!"
fi



# Creates a link form the config files in this directory to the original ~/.config/ directory
echo 'Creating symlinks...'
ln -f .config/kitty/kitty.conf ~/.config/kitty/kitty.conf
echo 'kitty configured'
ln -f .config/fish/config.fish ~/.config/fish/config.fish
echo 'fish configured'
cp .config/qtile/wallpaper.jpg ~/.config/qtile/wallpaper.jpg
ln -f .config/qtile/config.py ~/.config/qtile/config.py
echo 'qtile configured'

echo 'Installation finished :3'
echo "Enjoy this setup, for information on keybindings and extensive configuration of qtile see the README.md file in .config/qtile"
exit
