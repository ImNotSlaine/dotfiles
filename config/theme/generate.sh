#!/bin/bash

THEME="$1"
CONFIG_DIR="$HOME/.config"
THEME_DIR="$HOME/.config/theme"
THEME_FILE="$THEME_DIR/themes/$THEME.json"

if [ -z "$THEME" ]; then
	echo "Usage: ./generate.sh <themeName>"
	exit 1
fi

if [ ! -f "$THEME_FILE" ]; then
	echo "Theme not found: $THEME"
	exit 1
fi

# Gets colors from theme
eval $(jq -r 'to_entries | .[] | "\(.key)=\(.value)"' "$THEME_FILE")

# Kitty implement
cat <<EOF > "$CONFIG_DIR/kitty/_colors.conf"
# name $name
background $bg
foreground $fg
color0 $bg_alt
color1 $red
color2 $green
color3 $yellow
color4 $blue
color5 $magenta
color6 $cyan
color7 $fg
color8 $bg_alt
color9 $red_alt
color10 $green_alt
color11 $yellow_alt
color12 $blue_alt
color13 $magenta_alt
color14 $cyan_alt
color15 $fg
cursor_text_color $fg
active_tab_foreground $fg
active_tab_background $main
inactive_tab_foreground $fg
inactive_tab_background $bg
EOF

echo "Theme $THEME applied, make sure to have all the imports correct."
