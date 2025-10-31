#!/bin/bash

output_file="$HOME/.config/omarchy/current/theme/alacritty.toml"

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
