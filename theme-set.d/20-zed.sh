#!/bin/bash

input_file="$HOME/.config/omarchy/current/theme/alacritty.toml"
new_zed_file="$HOME/.config/omarchy/current/theme/zed.json"

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

create_dynamic_theme() {
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

    cat > "$new_zed_file" << EOF
    {
      "\$schema": "https://zed.dev/schema/themes/v0.1.0.json",
      "name": "Omarchyy",
      "author": "@bypass_",
      "themes": [
        {
          "name": "Omarchy",
          "appearance": "dark",
          "style": {
            "background": "${background}90",
            "editor.background": "${background}90",
            "editor.foreground": "${foreground}",
            "text": "${foreground}",
            "text.muted": "${foreground}70",
            "text.ignored": "${foreground}40",
            "text.placeholder": "${foreground}50",
            "ignored": "${foreground}30",
            "element.hover": "${foreground}30",
            "ghost_element.hover": "${bright_black}30",
            "ghost_element.selected": "${bright_black}30",
            "ghost_element.active": "${bright_black}60",
            "border": "${black}",
            "editor.highlighted_line.background": "${bright_black}10",
            "editor.active_line.background": "${bright_black}10",
            "panel.background": "${black}90",
            "title_bar.background": "${black}90",
            "title_bar.inactive_background": "${black}90",
            "status_bar.background": "${black}90",
            "drop_target.background": "${black}90",
            "elevated_surface.background": "${black}",
            "toolbar.background": "${black}90",
            "tab_bar.background": "${black}90",
            "tab.inactive_background": "${black}90",
            "tab.active_background": "${bright_black}30",
            "scrollbar.track.background": "transparent",
            "scrollbar.track.border": "${black}",
            "scrollbar.thumb.background": "${foreground}",
            "editor.gutter.background": "${black}90",
            "terminal.background": "${black}10",
            "terminal.foreground": "${foreground}",
            "terminal.dim_foreground": "${foreground}",
            "terminal.bright_foreground": "${foreground}",
            "terminal.ansi.black": "${black}",
            "terminal.ansi.red": "${red}",
            "terminal.ansi.green": "${green}",
            "terminal.ansi.yellow": "${yellow}",
            "terminal.ansi.blue": "${blue}",
            "terminal.ansi.magenta": "${magenta}",
            "terminal.ansi.cyan": "${cyan}",
            "terminal.ansi.white": "${white}",
            "terminal.ansi.bright_black": "${bright_black}",
            "terminal.ansi.bright_red": "${bright_red}",
            "terminal.ansi.bright_green": "${bright_green}",
            "terminal.ansi.bright_yellow": "${bright_yellow}",
            "terminal.ansi.bright_blue": "${bright_blue}",
            "terminal.ansi.bright_magenta": "${bright_magenta}",
            "terminal.ansi.bright_cyan": "${bright_cyan}",
            "terminal.ansi.bright_white": "${bright_white}",
            "modified": "${red}",
            "syntax": {
              "attribute": {
                "color": "${normal_white}"
              },
              "boolean": {
                "color": "${green}"
              },
              "comment": {
                "color": "${bright_black}"
              },
              "comment.doc": {
                "color": "${bright_black}"
              },
              "constant": {
                "color": "${bright_green}"
              },
              "function": {
                "color": "${bright_cyan}"
              },
              "keyword": {
                "color": "${blue}"
              },
              "number": {
                "color": "${magenta}"
              },
              "operator": {
                "color": "${blue}"
              },
              "string": {
                "color": "${red}"
              },
              "variable": {
                "color": "${green}"
              }
            },
            "players": [
              {
                "cursor": "${foreground}",
                "background": "${black}",
                "selection": "${foreground}30"
              }
            ]
          }
        }
      ]
    }
EOF
}

if ! command -v zeditor >/dev/null 2>&1; then
    warning "Zed not found. Install 'zed' to use.."
    exit 0
fi

mkdir -p "$HOME/.config/zed/themes"
if [ -f "$new_zed_file" ]; then
    cp -f "$new_zed_file" "$HOME/.config/zed/themes/omarchy.json"
else
    create_dynamic_theme
    cp -f "$new_zed_file" "$HOME/.config/zed/themes/omarchy.json"
fi

success "Zed theme updated!"
exit 0
