#!/bin/bash

output_file="$HOME/.config/omarchy/current/theme/kitty.conf"

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
