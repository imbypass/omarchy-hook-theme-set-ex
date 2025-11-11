#!/bin/bash

input_file="$HOME/.config/omarchy/current/theme/alacritty.toml"
output_file="$HOME/.config/omarchy/current/theme/steam.css"
theme_name=$1

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
                print "#" hex_part
                exit
            }
        }
    ' "$input_file"
}

if ! command -v python >/dev/null 2>&1; then
    warning "Python not found. Please install Python3 to use the Steam theme.."
    exit 0
fi

normal_black=$(extract_from_section "colors.normal" "black")
normal_red=$(extract_from_section "colors.normal" "red")
normal_green=$(extract_from_section "colors.normal" "green")
normal_yellow=$(extract_from_section "colors.normal" "yellow")
normal_blue=$(extract_from_section "colors.normal" "blue")
normal_magenta=$(extract_from_section "colors.normal" "magenta")
normal_cyan=$(extract_from_section "colors.normal" "cyan")
normal_white=$(extract_from_section "colors.normal" "white")
bright_black=$(extract_from_section "colors.bright" "black")
bright_red=$(extract_from_section "colors.bright" "red")
bright_green=$(extract_from_section "colors.bright" "green")
bright_yellow=$(extract_from_section "colors.bright" "yellow")
bright_blue=$(extract_from_section "colors.bright" "blue")
bright_magenta=$(extract_from_section "colors.bright" "magenta")
bright_cyan=$(extract_from_section "colors.bright" "cyan")
bright_white=$(extract_from_section "colors.bright" "white")

if [[ ! -f "$output_file" ]]; then
    cat > "$output_file" << EOF
/*

Omarchy Steam Theme
Last Modified: $(date +"%Y-%m-%d")

*/

:root {
    /* The main accent color and the matching text value */
    --adw-accent-bg-rgb: $(hex2rgb "${normal_blue}") !important;
    --adw-accent-fg-rgb: $(hex2rgb "${primary_background}") !important;
    --adw-accent-rgb: $(hex2rgb "${normal_blue}") !important;

    /* destructive-action buttons */
    --adw-destructive-bg-rgb: $(hex2rgb "${normal_red}") !important;
    --adw-destructive-fg-rgb: $(hex2rgb "${primary_foreground}") !important;
    --adw-destructive-rgb: $(hex2rgb "${normal_red}") !important;

    /* Levelbars, entries, labels and infobars. These don't need text colors */
    --adw-success-bg-rgb: $(hex2rgb "${normal_green}") !important;
    --adw-success-fg-rgb: $(hex2rgb "${normal_black}") !important;
    --adw-success-rgb: $(hex2rgb "${normal_green}") !important;

    --adw-warning-bg-rgb: $(hex2rgb "${bright_yellow}") !important;
    --adw-warning-fg-rgb: $(hex2rgb "${primary_background}") !important;
    --adw-warning-fg-a: 0.8 !important;
    --adw-warning-rgb: $(hex2rgb "${bright_yellow}") !important;

    --adw-error-bg-rgb: $(hex2rgb "${normal_red}") !important;
    --adw-error-fg-rgb: $(hex2rgb "${normal_black}") !important;
    --adw-error-rgb: $(hex2rgb "${normal_red}") !important;

    /* Window */
    --adw-window-bg-rgb: $(hex2rgb "${primary_background}") !important;
    --adw-window-fg-rgb: $(hex2rgb "${primary_foreground}") !important;

    /* Views - e.g. text view or tree view */
    --adw-view-bg-rgb: $(hex2rgb "${normal_black}") !important;
    --adw-view-fg-rgb: $(hex2rgb "${primary_foreground}") !important;

    /* Header bar, search bar, tab bar */
    --adw-headerbar-bg-rgb: $(hex2rgb "${primary_background}") !important;
    --adw-headerbar-fg-rgb: $(hex2rgb "${primary_foreground}") !important;
    --adw-headerbar-border-rgb: $(hex2rgb "${bright_black}") !important;
    --adw-headerbar-backdrop-rgb: $(hex2rgb "${normal_black}") !important;
    --adw-headerbar-shade-rgb: 0, 0, 0 !important;
    --adw-headerbar-shade-a: 0.36 !important;
    --adw-headerbar-darker-shade-rgb: 0, 0, 0 !important;
    --adw-headerbar-darker-shade-a: 0.9 !important;

    /* Split pane views */
    --adw-sidebar-bg-rgb: $(hex2rgb "${primary_background}") !important;
    --adw-sidebar-fg-rgb: $(hex2rgb "${primary_foreground}") !important;
    --adw-sidebar-backdrop-rgb: $(hex2rgb "${bright_black}") !important;
    --adw-sidebar-shade-rgb: 0, 0, 0 !important;
    --adw-sidebar-shade-a: 0.36 !important;

    --adw-secondary-sidebar-bg-rgb: $(hex2rgb "${primary_background}") !important;
    --adw-secondary-sidebar-fg-rgb: $(hex2rgb "${primary_foreground}") !important;
    --adw-secondary-sidebar-backdrop-rgb: $(hex2rgb "${bright_black}") !important;
    --adw-secondary-sidebar-shade-rgb: 0, 0, 0 !important;
    --adw-secondary-sidebar-shade-a: 0.36 !important;

    /* Cards, boxed lists */
    --adw-card-bg-rgb: 255, 255, 255 !important;
    --adw-card-bg-a: 0.08 !important;
    --adw-card-fg-rgb: 255, 255, 255 !important;
    --adw-card-shade-rgb: 0, 0, 0 !important;
    --adw-card-shade-a: 0.36 !important;

    /* Dialogs */
    --adw-dialog-bg-rgb: $(hex2rgb "${normal_black}") !important;
    --adw-dialog-fg-rgb: $(hex2rgb "${primary_foreground}") !important;

    /* Popovers */
    --adw-popover-bg-rgb: $(hex2rgb "${normal_black}") !important;
    --adw-popover-fg-rgb: $(hex2rgb "${primary_foreground}") !important;

    /* Thumbnails */
    --adw-thumbnail-bg-rgb: $(hex2rgb "${normal_black}") !important;
    --adw-popover-fg-rgb: $(hex2rgb "${primary_foreground}") !important;

    /* Miscellaneous */
    --adw-shade-rgb: 0, 0, 0 !important;
    --adw-shade-a: 0.36 !important;
}
EOF
fi

adwaita_location=$HOME/.local/share/steam-adwaita

install_steam_theme() {
    if [[ ! -d "$adwaita_location" ]]; then
        echo "Installing Steam theme files..."
        git clone https://github.com/tkashkin/Adwaita-for-Steam $adwaita_location > /dev/null 2>&1
    fi
}
modify_steam_theme() {
    font_name=$(omarchy-font-current)
    font_path=$(fc-list $font_name file | grep -ioP '.*\.ttf' | head -n 1)

    if [[ ! -d "$adwaita_location/adwaita/colorthemes/omarchy" ]]; then
        mkdir $adwaita_location/adwaita/colorthemes/omarchy/
    fi
    if [[ ! -d "$adwaita_location/adwaita/fonts/omarchy" ]]; then
        mkdir $adwaita_location/adwaita/fonts/omarchy/
        cat > $adwaita_location/adwaita/fonts/omarchy/omarchy.css <<EOF
@font-face {
    font-family: "$font_name";
    font-style: normal;
    font-weight: 100 900;
    src: url("omarchy_system.ttf");
    font-display: swap;
}

:root {
    --adw-text-font-primary: "$font_name" !important;
    --adw-text-font-monospace-primary: "$font_name" !important;
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

cp -p "$font_path" "$adwaita_location/adwaita/fonts/omarchy/omarchy_system.ttf"
cp -p "$output_file" "$adwaita_location/adwaita/colorthemes/omarchy/omarchy.css"

cd $adwaita_location && ./install.py \
    --color-theme omarchy \
    --extras library/hide_whats_new \
    --font omarchy \
    --custom-css > /dev/null 2>&1

success "Steam theme updated!"
exit
