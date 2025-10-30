#!/bin/bash

colors_file="$HOME/.config/omarchy/current/theme/colors.json"
output_file="$HOME/.config/omarchy/current/theme/mako.ini"

clean_color() {
    echo "$1" | sed "s/['\"]//g" | sed 's/#//g' | sed 's/0x//g' | sed 's/0X//g'
}

colors=(black red green yellow blue magenta cyan white)
declare -A normal_colors bright_colors

primary_background=$(clean_color "$(jq -r '.primary.background' $colors_file)")
primary_foreground=$(clean_color "$(jq -r '.primary.foreground' $colors_file)")
for color in "${colors[@]}"; do
    normal_colors[$color]=$(clean_color "$(jq -r ".normal.$color" $colors_file)")
    bright_colors[$color]=$(clean_color "$(jq -r ".bright.$color" $colors_file)")
done
font=$(omarchy-font-current)

if [[ ! -f "$output_file" ]]; then
    cat > "$output_file" << EOF
include=~/.local/share/omarchy/default/mako/core.ini

text-color=${primary_foreground}
border-color=${primary_foreground}
background-color=${primary_background}
padding=10
border-size=2
font=Liberation Sans 12
max-icon-size=32
outer-margin=5
EOF
fi
