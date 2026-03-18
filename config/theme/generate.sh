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

# Delete old colors
rm -f \
	"$CONFIG_DIR/kitty/_colors.conf" \
	"$CONFIG_DIR/hypr/sources/_colors.conf"


jq -r '                                                                                            
	.colors as $c |
	def get ($name):
		$c[$name] // null;
	def fallback($a; $b):
		if $a then $a else $b end;
	def hex($v):
		if $v then $v else "#000000" end;
	[ "black", "red", "green", "yellow", "blue", "magenta", "cyan", "white" ] as $base |
	
	"#---KITTY---",
	# Colors from 0 to 7
	(
		range(0;8) as $i |
			"color\($i) " + hex(get($base[$i]))
	),
	# Colors from 8 to 15
	(
		range(0;8) as $i |
			"color\($i+8) " + hex(get($base[$i] + "_alt"))
	),
	"",
	"background \($c.bg)",
	"foreground \($c.fg)",
	"",
	"active_tab_background \($c.main)",
	"active_tab_foreground \($c.fg)",
	"inactive_tab_background \($c.black)",
	"inactive_tab_foreground \($c.fg)",

	"#---HYPRLAND---",
	(
		$c |
			to_entries[] |
			select(.value | startswith("#")) |
			"$\(.key | gsub("-"; "_")) = rgba(\(.value[1:])ff)"
	),
	"",

	"#---STARSHIP---",
	' "$THEME_FILE" | awk '
		/^#---KITTY---/ { file="'$CONFIG_DIR'/kitty/_colors.conf"; next }
		/^#---HYPRLAND---/ { file="'$CONFIG_DIR'/hypr/sources/_colors.conf"; next }
		{ print >> file}
	'

# Kitty implement
echo "Theme $THEME applied, make sure to have all the imports correct."
