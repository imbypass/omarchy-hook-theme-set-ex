#!/bin/bash

colors_file="$HOME/.config/omarchy/current/theme/colors.json"
output_file="$HOME/.config/omarchy/current/theme/kitty.conf"

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
    cat > "$output_file" <<EOF
background            #${primary_background}
foreground            #${primary_foreground}

color0  #${normal_colors[black]}
color1  #${normal_colors[red]}
color2  #${normal_colors[green]}
color3  #${normal_colors[yellow]}
color4  #${normal_colors[blue]}
color5  #${normal_colors[magenta]}
color6  #${normal_colors[cyan]}
color7  #${normal_colors[white]}
color8  #${bright_colors[black]}
color9  #${bright_colors[red]}
color10 #${bright_colors[green]}
color11 #${bright_colors[yellow]}
color12 #${bright_colors[blue]}
color13 #${bright_colors[magenta]}
color14 #${bright_colors[cyan]}
color15 #${bright_colors[white]}
EOF
fi
