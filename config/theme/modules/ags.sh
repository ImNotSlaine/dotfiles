#!/bin/bash

CACHE="$1"
OUTPUT="$HOME/.config/ags/styles/modules/_colors.scss"

source "$CACHE"

cat > "$OUTPUT" <<EOF
:root {
	--bg_alpha: ${bg}cc;
	--bg: $bg;
	--fg: $fg;
	--main: $main;
	--main_alt: $main_alt;
}
EOF
