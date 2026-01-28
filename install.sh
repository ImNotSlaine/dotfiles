#!/bin/bash
# This script installs all the programs and sets the config files in the current directory, used in the github.com/ImNotSlaine/dotfiles.git.

echo 'Starting dotfiles installation...'

# Qtile
if pacman -Qs | grep -q "qtile"; then
	echo 'Qtile installed'
else
	echo 'Qtile not installed'
	echo 'Running pacman -S qtile...'
	sudo pacman -S qtile
fi

# Picom
if pacman -Qs | grep -q "picom"; then
	echo 'Picom installed'
else
	echo 'Picom not installed'
	echo 'Running pacman -S picom...'
	sudo pacman -S picom
fi

# Feh
if pacman -Qs | grep -q "feh"; then
	echo 'Feh installed'
else
	echo 'Feh not installed'
	echo 'Running pacman -S feh'
	sudo pacman -S feh
fi

# Kitty
if pacman -Qs | grep -q "kitty"; then
	echo 'Kitty installed'
else
	echo 'Kitty not installed'
	echo 'Running pacman -S kitty...'
	sudo pacman -S kitty
fi

# Creates a link form the config files in this directory to the original ~/.config/ directory
echo 'Creating symlinks...'
ln -f .config/kitty/kitty.conf ~/.config/kitty/kitty.conf
echo 'Kitty configured'
ln -f .config/fish/config.fish ~/.config/fish/config.fish
echo 'Fish configured'
ln -f .config/qtile/config.py ~/.config/qtile/config.py
echo 'Qtile configured'

echo 'Installation finished'
exit
