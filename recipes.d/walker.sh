#!/bin/bash

colors_file="$HOME/.config/omarchy/current/theme/colors.json"
output_file="$HOME/.config/walker/walker.css" # TODO: THIS SHOULD USE THE CURRENT/THEME DIR

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

cat > "$output_file" << EOF
@define-color selected-text #${normal_colors[yellow]};
@define-color selected-vibrant #${bright_colors[yellow]};
@define-color text #${primary_foreground};
@define-color base #${normal_colors[black]};
@define-color border #${bright_colors[black]};
@define-color foreground #${primary_foreground};
@define-color background #${primary_background};
EOF
