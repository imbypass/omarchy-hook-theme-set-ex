#!/bin/bash

input_file="$HOME/.config/omarchy/current/theme/alacritty.toml"
output_file="$HOME/.config/omarchy/current/theme/steam.css"

hex2rgb() {
    hex_input=$1
    r=$((16#${hex_input:0:2}))
    g=$((16#${hex_input:2:2}))
    b=$((16#${hex_input:4:2}))
    echo "$r, $g, $b"
}

success() {
    echo -e "\e[32m[SUCCESS]\e[0m $1"
}

warning() {
    echo -e "\033[0;33m[WARNING]\033[0;37m $1"
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

if ! command -v steam >/dev/null 2>&1; then
    warning "Steam not found. Please install Steam to use.."
    exit 0
fi

if ! command -v python >/dev/null 2>&1; then
    warning "Python not found. Please install Python3 to use.."
    exit 0
fi

primary_foreground=$(extract_from_section "colors.primary" "foreground")
primary_background=$(extract_from_section "colors.primary" "background")
rgb_primary_foreground=$(hex2rgb $primary_foreground)
rgb_primary_background=$(hex2rgb $primary_background)

normal_black=$(extract_from_section "colors.normal" "black")
normal_red=$(extract_from_section "colors.normal" "red")
normal_green=$(extract_from_section "colors.normal" "green")
normal_yellow=$(extract_from_section "colors.normal" "yellow")
normal_blue=$(extract_from_section "colors.normal" "blue")
normal_magenta=$(extract_from_section "colors.normal" "magenta")
normal_cyan=$(extract_from_section "colors.normal" "cyan")
normal_white=$(extract_from_section "colors.normal" "white")
rgb_normal_black=$(hex2rgb $normal_black)
rgb_normal_red=$(hex2rgb $normal_red)
rgb_normal_green=$(hex2rgb $normal_green)
rgb_normal_yellow=$(hex2rgb $normal_yellow)
rgb_normal_blue=$(hex2rgb $normal_blue)
rgb_normal_magenta=$(hex2rgb $normal_magenta)
rgb_normal_cyan=$(hex2rgb $normal_cyan)
rgb_normal_white=$(hex2rgb $normal_white)

bright_black=$(extract_from_section "colors.bright" "black")
bright_red=$(extract_from_section "colors.bright" "red")
bright_green=$(extract_from_section "colors.bright" "green")
bright_yellow=$(extract_from_section "colors.bright" "yellow")
bright_blue=$(extract_from_section "colors.bright" "blue")
bright_magenta=$(extract_from_section "colors.bright" "magenta")
bright_cyan=$(extract_from_section "colors.bright" "cyan")
bright_white=$(extract_from_section "colors.bright" "white")
rgb_bright_black=$(hex2rgb $bright_black)
rgb_bright_red=$(hex2rgb $bright_red)
rgb_bright_green=$(hex2rgb $bright_green)
rgb_bright_yellow=$(hex2rgb $bright_yellow)
rgb_bright_blue=$(hex2rgb $bright_blue)
rgb_bright_magenta=$(hex2rgb $bright_magenta)
rgb_bright_cyan=$(hex2rgb $bright_cyan)
rgb_bright_white=$(hex2rgb $bright_white)

if [[ ! -f "$output_file" ]]; then
    cat > "$output_file" << EOF
/*

Omarchy Steam Theme
Last Modified: $(date +"%Y-%m-%d")

*/

:root {
    /* The main accent color and the matching text value */
    --adw-accent-bg-rgb: ${rgb_normal_blue} !important;
    --adw-accent-fg-rgb: ${rgb_primary_background} !important;
    --adw-accent-rgb: ${rgb_normal_blue} !important;

    /* destructive-action buttons */
    --adw-destructive-bg-rgb: ${rgb_normal_red} !important;
    --adw-destructive-fg-rgb: ${rgb_primary_foreground} !important;
    --adw-destructive-rgb: ${rgb_normal_red} !important;

    /* Levelbars, entries, labels and infobars. These don't need text colors */
    --adw-success-bg-rgb: ${rgb_normal_green} !important;
    --adw-success-fg-rgb: ${rgb_normal_black} !important;
    --adw-success-rgb: ${rgb_normal_green} !important;

    --adw-warning-bg-rgb: ${rgb_bright_yellow} !important;
    --adw-warning-fg-rgb: ${rgb_primary_background} !important;
    --adw-warning-fg-a: 0.8 !important;
    --adw-warning-rgb: ${rgb_bright_yellow} !important;

    --adw-error-bg-rgb: ${rgb_normal_red} !important;
    --adw-error-fg-rgb: ${rgb_normal_black} !important;
    --adw-error-rgb: ${rgb_normal_red} !important;

    /* Window */
    --adw-window-bg-rgb: ${rgb_primary_background} !important;
    --adw-window-fg-rgb: ${rgb_primary_foreground} !important;

    /* Views - e.g. text view or tree view */
    --adw-view-bg-rgb: ${rgb_normal_black} !important;
    --adw-view-fg-rgb: ${rgb_primary_foreground} !important;

    /* Header bar, search bar, tab bar */
    --adw-headerbar-bg-rgb: ${rgb_primary_background} !important;
    --adw-headerbar-fg-rgb: ${rgb_primary_foreground} !important;
    --adw-headerbar-border-rgb: ${rgb_bright_black} !important;
    --adw-headerbar-backdrop-rgb: ${rgb_normal_black} !important;
    --adw-headerbar-shade-rgb: 0, 0, 0 !important;
    --adw-headerbar-shade-a: 0.36 !important;
    --adw-headerbar-darker-shade-rgb: 0, 0, 0 !important;
    --adw-headerbar-darker-shade-a: 0.9 !important;

    /* Split pane views */
    --adw-sidebar-bg-rgb: ${rgb_primary_background} !important;
    --adw-sidebar-fg-rgb: ${rgb_primary_foreground} !important;
    --adw-sidebar-backdrop-rgb: ${rgb_bright_black} !important;
    --adw-sidebar-shade-rgb: 0, 0, 0 !important;
    --adw-sidebar-shade-a: 0.36 !important;

    --adw-secondary-sidebar-bg-rgb: ${rgb_primary_background} !important;
    --adw-secondary-sidebar-fg-rgb: ${rgb_primary_foreground} !important;
    --adw-secondary-sidebar-backdrop-rgb: ${rgb_bright_black} !important;
    --adw-secondary-sidebar-shade-rgb: 0, 0, 0 !important;
    --adw-secondary-sidebar-shade-a: 0.36 !important;

    /* Cards, boxed lists */
    --adw-card-bg-rgb: 255, 255, 255 !important;
    --adw-card-bg-a: 0.08 !important;
    --adw-card-fg-rgb: 255, 255, 255 !important;
    --adw-card-shade-rgb: 0, 0, 0 !important;
    --adw-card-shade-a: 0.36 !important;

    /* Dialogs */
    --adw-dialog-bg-rgb: ${rgb_normal_black} !important;
    --adw-dialog-fg-rgb: ${rgb_primary_foreground} !important;

    /* Popovers */
    --adw-popover-bg-rgb: ${rgb_normal_black} !important;
    --adw-popover-fg-rgb: ${rgb_primary_foreground} !important;

    /* Thumbnails */
    --adw-thumbnail-bg-rgb: ${rgb_normal_black} !important;
    --adw-popover-fg-rgb: ${rgb_primary_foreground} !important;

    /* Miscellaneous */
    --adw-shade-rgb: 0, 0, 0 !important;
    --adw-shade-a: 0.36 !important;
}
EOF
fi

adwaita_location=$HOME/.local/share/steam-adwaita
font_path=$(fc-list $(omarchy-font-current) file | grep -ioP '.*\.ttf' | head -n 1)

install_steam_theme() {
    if [[ ! -d "$adwaita_location" ]]; then
        git clone https://github.com/tkashkin/Adwaita-for-Steam $adwaita_location > /dev/null 2>&1
    fi
}
modify_steam_theme() {

    if [[ ! -d "$adwaita_location/adwaita/colorthemes/omarchy" ]]; then
        mkdir $adwaita_location/adwaita/colorthemes/omarchy/
    fi
    if [[ ! -d "$adwaita_location/adwaita/fonts/omarchy" ]]; then
        mkdir $adwaita_location/adwaita/fonts/omarchy/
        cat > $adwaita_location/adwaita/fonts/omarchy/omarchy.css <<EOF
@font-face {
font-family: "Omarchy";
font-style: normal;
font-weight: 100 900;
src: url("omarchy.ttf");
font-display: swap;
}

:root {
--adw-text-font-primary: "Omarchy" !important;
--adw-text-font-monospace-primary: "Omarchy" !important;
}
EOF
    fi
}
modify_install_script() {
    if ! grep -q "omarchy" "$adwaita_location/install.py"; then
        sed -i.bak 's/\("cantarell"\)/\1, "omarchy"/' $adwaita_location/install.py
    fi
}

install_steam_theme
modify_steam_theme
modify_install_script

cp -p -f -v "$font_path" "$adwaita_location/adwaita/fonts/omarchy/omarchy.ttf"

cp -p -f -v "$output_file" "$adwaita_location/adwaita/colorthemes/omarchy/omarchy.css"

cd $adwaita_location && ./install.py \
    --color-theme omarchy \
    --extras library/hide_whats_new > /dev/null 2>&1

success "Steam theme updated!"
exit
