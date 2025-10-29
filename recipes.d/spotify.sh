#!/bin/bash

colors_file="$HOME/.config/omarchy/current/theme/colors.json"
output_colorini="$HOME/.config/spicetify/Themes/omarchy/color.ini"
output_usercss="$HOME/.config/spicetify/Themes/omarchy/user.css"

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

if ! command -v spicetify >/dev/null 2>&1; then
    warning "Spicetify not found. Install 'spicetify-cli' to use.."
    exit 0
fi

cat > "$output_colorini" << EOF
[system]
main                = ${primary_background}
player              = ${primary_background}
card                = ${primary_background}
main-elevated       = ${primary_background}
sidebar             = ${primary_background}
shadow              = ${primary_background}
misc                = ${normal_colors[white]}
selected-row        = ${normal_colors[white]}
button              = ${normal_colors[white]}
subtext             = ${normal_colors[white]}
notification-error  = ${normal_colors[red]}
button-active       = ${normal_colors[green]}
notification        = ${bright_colors[black]}
button-disabled     = ${bright_colors[black]}
highlight           = ${bright_colors[white]}
text                = ${bright_colors[white]}
EOF

cat > "$output_usercss" << EOF
*,
html,
body {
font-family: "${font}" !important;
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
