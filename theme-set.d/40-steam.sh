#!/bin/bash

input_file="$HOME/.config/omarchy/current/theme/alacritty.toml"
output_file="$HOME/.config/omarchy/current/theme/steam.css"

if ! command -v steam >/dev/null 2>&1; then
    warning "Steam not found. Skipping.."
    exit 0
fi

if ! command -v python >/dev/null 2>&1; then
    warning "Python not found. Skipping.."
    exit 0
fi

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

cp -p -f "$font_path" "$adwaita_location/adwaita/fonts/omarchy/omarchy.ttf"

cp -p -f "$output_file" "$adwaita_location/adwaita/colorthemes/omarchy/omarchy.css"

cd $adwaita_location && ./install.py \
    --color-theme omarchy \
    --extras library/hide_whats_new > /dev/null 2>&1

success "Steam theme updated!"
exit
