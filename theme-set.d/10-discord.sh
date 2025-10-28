#!/bin/bash
#
input_file="$HOME/.config/omarchy/current/theme/alacritty.toml"
output_file="$HOME/.config/omarchy/current/theme/vencord.theme.css"
possible_paths=(
    "$HOME/.config/Vencord"
    "$HOME/.config/vesktop"
    "$HOME/.config/equipbop"
    "/var/lib/flatpak/app/com.discordapp.Discord"
    "/var/lib/flatpak/app/dev.vencord.Vesktop"
    "/var/lib/flatpak/app/io.github.equicord.equibop"
)

extract_from_section() {
    local section="$1"
    local color_name="$2"
    awk -v section="[$section]" -v color="$color_name" '
        $0 == section { in_section=1; next }
        /^\[/ { in_section=0 }
        in_section && $1 == color {
            if (match($0, /(#|0x)[0-9a-fA-F]{6}/)) {
                hex_part = substr($0, RSTART + (substr($0, RSTART, 2) == "0x" ? 2 : 1), 6)
                print "#" hex_part
                exit
            }
        }
    ' "$input_file"
}

create_dynamic_theme() {
    color00=$(extract_from_section "colors.primary" "background")
    color01=$(extract_from_section "colors.normal" "black")
    color02=$(extract_from_section "colors.bright" "black")
    color03=$(extract_from_section "colors.normal" "white")
    color04=$(extract_from_section "colors.bright" "white")
    color05=$(extract_from_section "colors.primary" "foreground")
    color06=$(extract_from_section "colors.bright" "white")
    color07=$(extract_from_section "colors.bright" "white")
    color08=$(extract_from_section "colors.normal" "red")
    color09=$(extract_from_section "colors.normal" "yellow")
    color0A=$(extract_from_section "colors.bright" "yellow")
    color0B=$(extract_from_section "colors.normal" "green")
    color0C=$(extract_from_section "colors.normal" "cyan")
    color0D=$(extract_from_section "colors.normal" "blue")
    color0E=$(extract_from_section "colors.normal" "magenta")
    color0F=$(extract_from_section "colors.bright" "red")

    cat > "$output_file" << EOF
    /**
    * @name Match System
    * @author @bypass_
    * @version 0.1.0
    * @description Match Omarchy system theme.
    * @source https://github.com/imbypass/base16-Discord
    **/
    @import url("https://imbypass.github.io/base16-discord/omarchy-discord.theme.css");

    :root {
        --color00: ${color00};
        --color01: ${color00};
        --color02: ${color00};
        --color03: ${color03};
        --color04: ${color07};
        --color05: ${color07};
        --color06: ${color07};
        --color07: ${color07};
        --color08: ${color07};
        --color09: ${color09};
        --color10: ${color0A};
        --color11: ${color0B};
        --color12: ${color0C};
        --color13: ${color0D};
        --color14: ${color0E};
        --color15: ${color09};
    }
EOF


    for path in "${possible_paths[@]}"; do
        if [ -d "$path" ]; then

            if [[ -f "$path/themes/vencord.theme.css" ]]; then
                rm "$path/themes/vencord.theme.css"
            fi

            cp "$output_file" "$path/themes/vencord.theme.css"

            for file in "$path"/themes/*; do
                if [ -f "$file" ]; then
                    touch "$file"
                fi
            done
        fi
    done
}

check_for_theme() {
    if [[ -f $HOME/.config/omarchy/current/theme/vencord.theme.css ]]; then
        for path in "${possible_paths[@]}"; do
            if [ -d "$path/themes" ]; then
                if [[ -f "$path/themes/vencord.theme.css" ]]; then
                    rm "$path/themes/vencord.theme.css"
                fi
                cp -f $HOME/.config/omarchy/current/theme/vencord.theme.css "$path/themes/vencord.theme.css"
            fi

            for file in "$path"/themes/*; do
                if [ -f "$file" ]; then
                    touch "$file"
                fi
            done
        done
    else
        create_dynamic_theme
    fi
}

check_for_theme

printf "\033[0;32m[SUCCESS]\033[0;37m Discord theme updated!\n"
