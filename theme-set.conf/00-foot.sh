#!/bin/bash

input_file="$HOME/.config/omarchy/current/theme/alacritty.toml"
output_file="$HOME/.config/foot/colors.ini"

clean_color() {
    echo "$1" | sed "s/['\"]//g" | sed 's/#//g' | sed 's/0x//g' | sed 's/0X//g'
}

primary_bg=$(clean_color "$(grep -A 2 "\[colors.primary\]" "$input_file" | grep "background" | cut -d= -f2 | xargs)")
primary_fg=$(clean_color "$(grep -A 2 "\[colors.primary\]" "$input_file" | grep "foreground" | cut -d= -f2 | xargs)")

colors=(black red green yellow blue magenta cyan white)

declare -A normal_colors bright_colors
for color in "${colors[@]}"; do
    normal_colors[$color]=$(clean_color "$(grep -A 8 "\[colors.normal\]" "$input_file" | grep "$color" | head -1 | cut -d= -f2 | xargs)")
    bright_colors[$color]=$(clean_color "$(grep -A 8 "\[colors.bright\]" "$input_file" | grep "$color" | head -1 | cut -d= -f2 | xargs)")
done

cat > "$output_file" << EOF
[colors]
background=$primary_bg
foreground=$primary_fg
EOF

for i in "${!colors[@]}"; do
    echo "regular$i=${normal_colors[${colors[$i]}]}" >> "$output_file"
done

for i in "${!colors[@]}"; do
    echo "bright$i=${bright_colors[${colors[$i]}]}" >> "$output_file"
done

echo "Foot theme updated!"
