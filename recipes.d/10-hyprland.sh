#!/bin/bash

output_file="$HOME/.config/omarchy/current/theme/hyprland.conf"

if [[ ! -f "$output_file" ]]; then
    cat > "$output_file" << EOF
# This file is not a full hyprland configuration.
# It is intended to be included in your main hyprland.conf.

general {
    col.active_border = rgba(${primary_foreground}ff)
    col.inactive_border = rgba(1f1f1fff)
    border_size = 2
}
EOF
fi
