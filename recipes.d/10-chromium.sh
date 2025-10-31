#!/bin/bash

output_file="$HOME/.config/omarchy/current/theme/chromium.theme"

r=$((16#${primary_background:0:2}))
g=$((16#${primary_background:2:2}))
b=$((16#${primary_background:4:2}))

if [[ ! -f "$output_file" ]]; then
    cat > "$output_file" << EOF
${r},${g},${b}
EOF
fi
