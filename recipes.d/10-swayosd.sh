#!/bin/bash

colors_file="$HOME/.config/omarchy/current/theme/colors.json"
output_file="$HOME/.config/omarchy/current/theme/swayosd.css" # TODO: THIS SHOULD USE THE CURRENT/THEME DIR

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
@define-color background-color #${primary_background};
@define-color border-color #${primary_foreground};
@define-color label #${primary_foreground};
@define-color image #${primary_foreground};
@define-color progress ${primary_foreground};
EOF
fi
