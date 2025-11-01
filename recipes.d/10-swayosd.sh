#!/bin/bash

output_file="$HOME/.config/omarchy/current/theme/swayosd.css"

if [[ ! -f "$output_file" ]]; then
    cat > "$output_file" << EOF
@define-color background-color #${primary_background};
@define-color border-color #${primary_foreground};
@define-color label #${primary_foreground};
@define-color image #${primary_foreground};
@define-color progress ${primary_foreground};
EOF
fi

omarchy-restart-swayosd
