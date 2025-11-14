#!/bin/bash

input_file="$HOME/.config/omarchy/current/theme/alacritty.toml"
new_qt_file="$HOME/.config/omarchy/current/theme/qt6ct.conf"

success() {
    echo -e "\e[32m[SUCCESS]\e[0m $1"
}

hex2rgb() {
    hex_input=$1
    r=$((16#${hex_input:0:2}))
    g=$((16#${hex_input:2:2}))
    b=$((16#${hex_input:4:2}))
    echo "$r, $g, $b"
}

rgb2hex() {
    r=$1
    g=$2
    b=$3
    printf "%02x%02x%02x" $r $g $b
}

change_shade() {
    local hex_color=$1
    local shade=$2
    hex_input=$1
    r=$((16#${hex_input:0:2}))
    g=$((16#${hex_input:2:2}))
    b=$((16#${hex_input:4:2}))

    r=$((r + shade))
    g=$((g + shade))
    b=$((b + shade))

    rgb2hex $r $g $b
}

extract_from_section() {
    local section="$1"
    local color_name="$2"
    awk -v section="[$section]" -v color="$color_name" '
        $0 == section { in_section=1; next }
        /^\[/ { in_section=0 }
        in_section && $1 == color {
            if (match($0, /(#|0x)([0-9a-fA-F]{6})/)) {
                hex_part = substr($0, RSTART + (substr($0, RSTART, 2) == "0x" ? 2 : 1), 6)
                print hex_part
                exit
            }
        }
    ' "$input_file"
}

if ! command -v qt6ct >/dev/null 2>&1; then
    warning "Qt6ct not found. Install 'qt6ct' to use..\n"
    exit 0
fi

background=$(extract_from_section "colors.primary" "background")
foreground=$(extract_from_section "colors.primary" "foreground")
black=$(extract_from_section "colors.normal" "black")
red=$(extract_from_section "colors.normal" "red")
green=$(extract_from_section "colors.normal" "green")
yellow=$(extract_from_section "colors.normal" "yellow")
blue=$(extract_from_section "colors.normal" "blue")
magenta=$(extract_from_section "colors.normal" "magenta")
cyan=$(extract_from_section "colors.normal" "cyan")
white=$(extract_from_section "colors.normal" "white")
bright_black=$(extract_from_section "colors.bright" "black")
bright_red=$(extract_from_section "colors.bright" "red")
bright_green=$(extract_from_section "colors.bright" "green")
bright_yellow=$(extract_from_section "colors.bright" "yellow")
bright_blue=$(extract_from_section "colors.bright" "blue")
bright_magenta=$(extract_from_section "colors.bright" "magenta")
bright_cyan=$(extract_from_section "colors.bright" "cyan")
bright_white=$(extract_from_section "colors.bright" "white")

base00=$black
base01=$(change_shade $black 5)
base02=$(change_shade $black 10)
base03=$(change_shade $black 15)
base04=$(change_shade $black 20)
base05=$foreground
base06=$(change_shade $foreground -5)
base07=$(change_shade $foreground -10)
base08=$(extract_from_section "colors.normal" "red")
base09=$(extract_from_section "colors.normal" "yellow")
base0A=$(extract_from_section "colors.bright" "yellow")
base0B=$(extract_from_section "colors.normal" "green")
base0C=$(extract_from_section "colors.normal" "cyan")
base0D=$(extract_from_section "colors.normal" "blue")
base0E=$(extract_from_section "colors.normal" "magenta")
base0F=$(extract_from_section "colors.bright" "red")

if [ ! -f "$new_qt_file" ]; then
    cat > "$new_qt_file" << EOF
[ColorScheme]
active_colors=#ff${base05}, #ff${base01}, #ff${base01}, #ff${base05}, #ff${base03}, #ff${base04}, #ff${base05}, #ff${base06}, #ff${base05}, #ff${base01}, #ff${base00}, #ff${base03}, #ff${base02}, #ff${base05}, #ff${base09}, #ff${base08}, #ff${base02}, #ff${base05}, #ff${base01}, #ff${base05}, #8f${base05}
disabled_colors=#ff${base00}, #ff${base01}, #ff${base01}, #ff${base04}, #ff${base03}, #ff${base04}, #ff${base00}, #ff${base00}, #ff${base00}, #ff${base01}, #ff${base00}, #ff${base03}, #ff${base02}, #ff${base04}, #ff${base09}, #ff${base08}, #ff${base02}, #ff${base04}, #ff${base01}, #ff${base00}, #8f${base00}
inactive_colors=#ff${base04}, #ff${base01}, #ff${base01}, #ff${base05}, #ff${base03}, #ff${base04}, #ff${base05}, #ff${base06}, #ff${base05}, #ff${base01}, #ff${base00}, #ff${base03}, #ff${base02}, #ff${base05}, #ff${base09}, #ff${base08}, #ff${base02}, #ff${base05}, #ff${base01}, #ff${base05}, #8f${base05}
EOF
fi

mkdir -p "$HOME/.config/qt6ct/colors"
cp -p -f "$new_qt_file" "$HOME/.config/qt6ct/colors/omarchy.conf"

exit 0
