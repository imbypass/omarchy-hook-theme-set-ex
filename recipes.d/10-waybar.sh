#!/bin/bash

output_file="$HOME/.config/omarchy/current/theme/waybar.css"

if [[ ! -f "$output_file" ]]; then
    cat > "$output_file" << EOF
@define-color background #${primary_background};
@define-color foreground #${primary_foreground};
@define-color black #${normal_colors[black]};
@define-color red #${normal_colors[red]};
@define-color green #${normal_colors[green]};
@define-color yellow #${normal_colors[yellow]};
@define-color blue #${normal_colors[blue]};
@define-color magenta #${normal_colors[magenta]};
@define-color cyan #${normal_colors[cyan]};
@define-color white #${normal_colors[white]};
@define-color bright_black #${bright_colors[black]};
@define-color bright_red #${bright_colors[red]};
@define-color bright_green #${bright_colors[green]};
@define-color bright_yellow #${bright_colors[yellow]};
@define-color bright_blue #${bright_colors[blue]};
@define-color bright_magenta #${bright_colors[magenta]};
@define-color bright_cyan #${bright_colors[cyan]};
@define-color bright_white #${bright_colors[white]};
EOF
fi
