#!/bin/bash

THEME="$1"
THEME_DIR="$HOME/.config/theme"
THEME_FILE="$THEME_DIR/themes/$THEME.json"
MODULES_DIR="$THEME_DIR/modules"
CACHE_FILE="/tmp/theme_cache.sh"

if [ -z "$THEME" ]; then
	echo "Usage: ./generate.sh <themeName>"
	exit 1
fi

if [ ! -f "$THEME_FILE" ]; then
	echo "Theme not found: $THEME"
	exit 1
fi

# Delete old colors
jq -r '
	.meta | 
	to_entries[] |
	(.key) + "=" + "\"" + (.value) + "\""
	' "$THEME_FILE" > "$CACHE_FILE"

jq -r '
	.colors |
	to_entries[] |
	(.key) + "=" + "\"" + (.value) + "\""
	' "$THEME_FILE" > "$CACHE_FILE"

# Modules loop
for module in "$MODULES_DIR"/*.sh; do
	name=$(basename "$module" .sh)

	echo "Generating $name ..."
	bash "$module" "$CACHE_FILE"
done

# Kitty implement
echo "Theme $THEME applied, make sure to have all the imports correct."
