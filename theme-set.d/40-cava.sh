#!/bin/bash

if ! command -v cava >/dev/null 2>&1; then
    skipped "CAVA"
fi

# Generate theme file
theme_dir="$HOME/.config/cava/themes"
theme_file="$theme_dir/omarchy"

mkdir -p "$theme_dir"

cat > "$theme_file" << EOF
[color]
gradient = 1
gradient_count = 8
gradient_color_1 = '#${normal_cyan:-${primary_foreground}}'
gradient_color_2 = '#${normal_blue:-${primary_foreground}}'
gradient_color_3 = '#${bright_blue:-${normal_blue:-${primary_foreground}}}'
gradient_color_4 = '#${normal_magenta:-${primary_foreground}}'
gradient_color_5 = '#${bright_magenta:-${normal_magenta:-${primary_foreground}}}'
gradient_color_6 = '#${bright_cyan:-${normal_cyan:-${primary_foreground}}}'
gradient_color_7 = '#${bright_magenta:-${normal_magenta:-${primary_foreground}}}'
gradient_color_8 = '#${normal_cyan:-${primary_foreground}}'
EOF

# Ensure main config uses omarchy theme
config_file="$HOME/.config/cava/config"
if [ -f "$config_file" ] && ! grep -q "theme = 'omarchy'" "$config_file"; then
    sed -i "/^\[color\]/a theme = 'omarchy'" "$config_file"
fi

if pgrep -x cava >/dev/null 2>&1; then
    ( pkill -USR2 cava ) >/dev/null 2>&1 &
fi

success "CAVA theme synced"
exit 0
