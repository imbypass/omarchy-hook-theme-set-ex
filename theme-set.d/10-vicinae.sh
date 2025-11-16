#!/bin/bash

output_file="$HOME/.config/omarchy/current/theme/vicinae.toml"

if ! command -v vicinae >/dev/null 2>&1; then
    skipped "Vicinae"
fi

if [ ! -f "$output_file" ]; then
    cat > "$output_file" << EOF
[meta]
version = 1
name = "Omarchy"
description = "Follow your Omarchy system theme."
variant = "dark"
inherits = "vicinae-dark"

[colors.core]
background = "#${normal_black}"
foreground = "#${primary_foreground}"
secondary_background = "#$(change_shade $normal_black 5)"
border = "#${bright_black}"
accent = "#${normal_yellow}"

[colors.accents]
blue = "#${normal_blue}"
green = "#${normal_green}"
magenta = "#${normal_magenta}"
orange = "#${normal_yellow}"
purple = "#${normal_purple}"
red = "#${normal_red}"
yellow = "#${bright_yellow}"
cyan = "#${normal_cyan}"
EOF
fi

mkdir -p "$HOME/.local/share/vicinae/themes/"
cp -p -f "$output_file" "$HOME/.local/share/vicinae/themes/omarchy.toml"

success "Vicinae theme updated!"
exit 0
