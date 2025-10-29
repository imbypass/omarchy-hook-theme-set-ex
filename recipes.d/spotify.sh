#!/bin/bash

colors_file="$HOME/.config/omarchy/current/theme/colors.json"

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

primary_background=$(clean_color "$(jq -r '.primary.background' $colors_file)")
primary_foreground=$(clean_color "$(jq -r '.primary.foreground' $colors_file)")
for color in "${colors[@]}"; do
    normal_colors[$color]=$(clean_color "$(jq -r ".normal.$color" $colors_file)")
    bright_colors[$color]=$(clean_color "$(jq -r ".bright.$color" $colors_file)")
done
font=$(omarchy-font-current)

process_template() {
    if [[ -f "templates.d/spicetify/color.ini" ]]; then
        cp -f "templates.d/spicetify/color.ini" "output/spicetify/color.ini"
    fi
    if [[ -f "templates.d/spicetify/user.css" ]]; then
        cp -f "templates.d/spicetify/user.css" "output/spicetify/user.css"
    fi

    info "Processing color.ini.."
    sed -i "s/%background%/${primary_background}/g" "output/spicetify/color.ini"

    for color in "${colors[@]}"; do
        sed -i "s/%${color}%/${normal_colors[$color]}/g" "output/spicetify/color.ini"
        sed -i "s/%bright_${color}%/${bright_colors[$color]}/g" "output/spicetify/color.ini"
    done

    info "Processing user.css.."
    sed -i "s/%font%/${font}/g" "output/spicetify/user.css"
}


apply_theme() {
    mkdir -p "$HOME/.config/spicetify/Themes/omarchy"

    cp -f "output/spicetify/user.css" "$HOME/.config/spicetify/Themes/omarchy/user.css"
    cp -f "output/spicetify/color.ini" "$HOME/.config/spicetify/Themes/omarchy/color.ini"

    config_file="$HOME/.config/spicetify/config-xpui.ini"

    sed -i "s/^current_theme[[:space:]]*=.*/current_theme        = omarchy/" "$config_file"
    sed -i "s/^color_scheme[[:space:]]*=.*/color_scheme           = system/" "$config_file"

    success "Spotify theme updated!"
    spicetify apply > /dev/null 2>&1 & exit 0
    exit 0
}

if ! command -v spicetify >/dev/null 2>&1; then
    warning "Spicetify not found. Install 'spicetify-cli' to use.."
    exit 0
fi

process_template
apply_theme
