#!/bin/bash

output_file="$HOME/.config/omarchy/current/theme/ghostty.conf"

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
