#!/bin/bash

output_file="$HOME/.config/omarchy/current/theme/walker.css"

if [[ ! -f "$output_file" ]]; then
    cat > "$output_file" << EOF
@define-color selected-text #${normal_colors[yellow]};
@define-color selected-vibrant #${bright_colors[yellow]};
@define-color text #${primary_foreground};
@define-color base #${normal_colors[black]};
@define-color border #${bright_colors[black]};
@define-color foreground #${primary_foreground};
@define-color background #${primary_background};
EOF
fi
