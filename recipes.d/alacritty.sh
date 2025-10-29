#!/bin/bash

colors_file="$HOME/.config/omarchy/current/theme/colors.json"
output_file="$HOME/.config/omarchy/current/theme/alacritty.toml" # TODO: THIS SHOULD USE THE CURRENT/THEME DIR

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
[window]
opacity = 0.9

[colors]
transparent_background_colors = true

[colors.primary]
background  = "#${primary_background}"
foreground  = "#${primary_foreground}"

[colors.normal]
black       = "#${normal_colors[black]}"
red         = "#${normal_colors[red]}"
green       = "#${normal_colors[green]}"
yellow      = "#${normal_colors[yellow]}"
blue        = "#${normal_colors[blue]}"
magenta     = "#${normal_colors[magenta]}"
cyan        = "#${normal_colors[cyan]}"
white       = "#${normal_colors[white]}"

[colors.bright]
black       = "#${bright_colors[black]}"
red         = "#${bright_colors[red]}"
green       = "#${bright_colors[green]}"
yellow      = "#${bright_colors[yellow]}"
blue        = "#${bright_colors[blue]}"
magenta     = "#${bright_colors[magenta]}"
cyan        = "#${bright_colors[cyan]}"
white       = "#${bright_colors[white]}"
EOF
fi
