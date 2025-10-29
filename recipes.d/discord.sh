#!/bin/bash

colors_file="$HOME/.config/omarchy/current/theme/colors.json"
template="vencord.theme.css"

discord_clients=(
    "$HOME/.config/Vencord"
    "$HOME/.config/vesktop"
    "$HOME/.config/equipbop"
    "/var/lib/flatpak/app/com.discordapp.Discord"
    "/var/lib/flatpak/app/dev.vencord.Vesktop"
    "/var/lib/flatpak/app/io.github.equicord.equibop"
)

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
    for client in "${discord_clients[@]}"; do
        if [ -d "$client" ]; then

            if [[ -f "$client/themes/vencord.theme.css" ]]; then
                rm "$client/themes/vencord.theme.css"
            fi
            cp -f "output/$template" "$client/themes/vencord.theme.css"

            for file in "$client/themes/*"; do
                if [ -f "$file" ]; then
                    touch "$file"
                fi
            done
        fi
    done
}

process_template
apply_theme

success "Discord theme updated!"
exit 0
