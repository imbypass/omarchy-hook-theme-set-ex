#!/bin/bash
#
input_file="$HOME/.config/omarchy/current/theme/alacritty.toml"

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
            if (match($0, /(#|0x)[0-9a-fA-F]{6}/)) {
                print substr($0, RSTART+1, RLENGTH-1)
                exit
            }
        }
    ' "$input_file"
}

create_spicetify_styling() {
    mkdir -p "$HOME/.config/spicetify/Themes/omarchy"
    cat > "$HOME/.config/spicetify/Themes/omarchy/user.css" << EOF
*,
html,
body {
    font-family: "$(omarchy-font-current)" !important;
}
:root,
.encore-dark-theme,
.encore-base-set,
.encore-inverted-light-set {
    --background-highlight: rgba(var(--spice-rgb-highlight), 0.25) !important;
}
.main-nowPlayingBar-container {
    background-color: var(--background-base);
    border-radius: 0.5rem;
    padding: 0.5rem;
    color: var(--spice-text);
}
.main-entityHeader-backgroundColor {
    display: none !important;
}
.main-actionBarBackground-background {
    display: none !important;
}
.main-home-homeHeader {
    display: none !important;
}
.main-topBar-background,
.main-home-filterChipsSection {
    background-color: var(--spice-main) !important;
}
EOF
}

change_spicetify_theme() {
    spicetify config current_theme omarchy
    spicetify config color_scheme base
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

    cat > "$HOME/.config/spicetify/Themes/omarchy/color.ini" << EOF
[base]
main                = ${color00}
player              = ${color00}
card                = ${color00}
main-elevated       = ${color00}
sidebar             = ${color00}
shadow              = ${color00}
notification        = ${color02}
button-disabled     = ${color02}
misc                = ${color03}
selected-row        = ${color03}
button              = ${color03}
highlight           = ${color07}
notification-error  = ${color08}
button-active       = ${color0B}
subtext             = ${color03}
text                = ${color07}
EOF
}

if ! command -v spicetify >/dev/null 2>&1; then
    warning "Spicetify not found. Install 'spicetify-cli' to use..\n"
    exit 0
fi

spotify_was_running=false
if pgrep -x "spotify" > /dev/null 2>&1; then
    spotify_was_running=true
fi

create_spicetify_styling
create_dynamic_theme
change_spicetify_theme

if [ "$spotify_was_running" = true ]; then
       spicetify apply > /dev/null 2>&1 &
else
    setsid bash -c '
        spicetify apply > /dev/null 2>&1 &

        for i in {1..250}; do
            if pgrep -x "spotify" > /dev/null 2>&1; then
                sleep 0.2
                killall -9 spotify > /dev/null 2>&1
                exit 0
            fi
            sleep 0.1
        done
    ' > /dev/null 2>&1 < /dev/null &
fi

success "Spotify theme updated!"
exit
