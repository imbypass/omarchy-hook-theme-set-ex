#!/bin/bash

output_file="$HOME/.config/omarchy/current/theme/chromium.theme"

if [[ ! -f "$output_file" ]]; then
    cat > "$output_file" << EOF
$(hex2rgb $primary_background)
EOF
fi
exit 0
