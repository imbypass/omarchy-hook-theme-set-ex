#!/bin/bash

colors_file="$HOME/.config/omarchy/current/theme/colors.json"
output_file="$HOME/.config/omarchy/current/theme/ghostty.conf" # TODO: THIS SHOULD USE THE CURRENT/THEME DIR

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
font-family = "${font}"
background = #${primary_background}
foreground = #${primary_foreground}

palette = 0=#${normal_colors[black]}
palette = 1=#${normal_colors[red]}
palette = 2=#${normal_colors[green]}
palette = 3=#${normal_colors[yellow]}
palette = 4=#${normal_colors[blue]}
palette = 5=#${normal_colors[magenta]}
palette = 6=#${normal_colors[cyan]}
palette = 7=#${normal_colors[white]}

palette = 8=#${bright_colors[black]}
palette = 9=#${bright_colors[red]}
palette = 10=#${bright_colors[green]}
palette = 11=#${bright_colors[yellow]}
palette = 12=#${bright_colors[blue]}
palette = 13=#${bright_colors[magenta]}
palette = 14=#${bright_colors[cyan]}
palette = 15=#${bright_colors[white]}
EOF
fi
