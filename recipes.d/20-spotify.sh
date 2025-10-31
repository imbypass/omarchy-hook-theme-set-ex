#!/bin/bash

output_file="$HOME/.config/omarchy/current/theme/spicetify_color.ini"

if ! command -v spicetify >/dev/null 2>&1; then
    echo -e "[WARNING]: Spicetify not found. Install 'spicetify-cli' to use.."
    exit 0
fi

mkdir -p "$HOME/.config/spicetify/Themes/omarchy"

if [[ ! -f "$output_file" ]]; then
    cat > "$output_file" << EOF
[system]
main                = ${primary_background}
player              = ${primary_background}
card                = ${primary_background}
main-elevated       = ${primary_background}
sidebar             = ${primary_background}
shadow              = ${primary_background}
misc                = ${normal_white}
selected-row        = ${normal_white}
button              = ${normal_white}
subtext             = ${normal_white}
notification-error  = ${normal_red}
button-active       = ${normal_green}
notification        = ${bright_black}
button-disabled     = ${bright_black}
highlight           = ${bright_white}
text                = ${bright_white}
EOF
fi

output_usercss=""$HOME/.config/spicetify/Themes/omarchy/user.css""
cat > "$output_usercss" << EOF
*,
html,
body {
font-family: "${font}" !important;
}

.playlist-playlist-actionBarBackground-background {
    background-image: none !important;
    --text-subdued: var(--spice-text) !important;
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

cp $output_file "$HOME/.config/spicetify/Themes/omarchy/color.ini"

spicetify config current_theme omarchy > /dev/null 2>&1
spicetify config color_scheme base > /dev/null 2>&1
spicetify apply > /dev/null 2>&1 & exit 0
