#!/bin/bash

colors_file="$HOME/.config/omarchy/current/theme/colors.json"
output_file="$HOME/.config/omarchy/current/theme/chromium.theme"

clean_color() {
    echo "$1" | sed "s/['\"]//g" | sed 's/#//g' | sed 's/0x//g' | sed 's/0X//g'
}

primary_background=$(clean_color "$(jq -r '.primary.background' $colors_file)")

r=$((16#${primary_background:0:2}))
g=$((16#${primary_background:2:2}))
b=$((16#${primary_background:4:2}))

if [[ ! -f "$output_file" ]]; then
    cat > "$output_file" << EOF
${r},${g},${b}
EOF
fi
