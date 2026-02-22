# Welcome to my dotfiles

## System Information

- **OS** - [Arch Linux](archlinux.org)
- **WM** - [Hyprland](hypr.land)
- **Compositor** - [Wayland](wayland.freedesktop.org)
- **Terminal** - [kitty](github.com/kovidgoyal/kitty)
- **Shell** - Bash with [Starship](starship.rs)

## Other configured apps

- **Editor** - [NeoVim](neovim.io)
- **App launcher** - [Rofi](github.com/davatorium/rofi)
- **Notifications** - [Dunst](dunst-project.org)
- **Bar** - [Waybar](github.com/Alexays/Waybar)
- **File manager** - [Ranger](github.com/ranger/ranger)

### Information about scripts

The install.sh script will search for all programs used in this dotfiles and install them, then it creates symlinks from the local copy repository to where the config should be, in this process it also checks and creates any needed directories.

If you already have all packages installed or want to skip all messages, just run configdotfiles.sh or fastinstall.sh, **remember that fastinstall.sh will still ask for sudo password**.
