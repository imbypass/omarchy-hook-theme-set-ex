#!/bin/bash

colors_file="$HOME/.config/omarchy/current/theme/colors.toml"
template="gtk.css"

success() {
    echo -e "\e[32m[SUCCESS]\e[0m $1"
}

warning() {
    echo -e "\033[0;33m[WARNING]\033[0;37m $1"
}

info() {
    echo -e "\e[34m[INFO]\e[0m $1"
}

error() {
    echo -e "\e[31m[ERROR]\e[0m $1"
    exit 1
}

clean_color() {
    echo "$1" | sed "s/['\"]//g" | sed 's/#//g' | sed 's/0x//g' | sed 's/0X//g'
}

colors=(black red green yellow blue magenta cyan white)
declare -A normal_colors bright_colors

primary_background=$(clean_color "$(grep -A 2 "\[primary\]" "$colors_file" | grep "background" | cut -d= -f2 | xargs)")
primary_foreground=$(clean_color "$(grep -A 2 "\[primary\]" "$colors_file" | grep "foreground" | cut -d= -f2 | xargs)")
for color in "${colors[@]}"; do
    normal_colors[$color]=$(clean_color "$(grep -A 8 "\[normal\]" "$colors_file" | grep "$color" | head -1 | cut -d= -f2 | xargs)")
    bright_colors[$color]=$(clean_color "$(grep -A 8 "\[bright\]" "$colors_file" | grep "$color" | head -1 | cut -d= -f2 | xargs)")
done
font=$(omarchy-font-current)

process_template() {
    if [[ -f "templates.d/$template" ]]; then
        info "Processing $(basename $template).."
        cp "templates.d/$template" "output/${template##*/}"

        sed -i "s/%background%/${primary_background}/g" "output/${template##*/}"
        sed -i "s/%foreground%/${primary_foreground}/g" "output/${template##*/}"

        for color in "${colors[@]}"; do
            sed -i "s/%${color}%/${normal_colors[$color]}/g" "output/${template##*/}"
            sed -i "s/%bright_${color}%/${bright_colors[$color]}/g" "output/${template##*/}"
        done

        sed -i "s/%font%/${font}/g" "output/${template##*/}"
    fi
}

apply_theme() {
    cp -f "output/$template" "$HOME/.config/gtk-3.0/gtk.css"
    cp -f "output/$template" "$HOME/.config/gtk-4.0/gtk.css"
}

process_template
apply_theme

success "GTK theme updated!"
exit 0
