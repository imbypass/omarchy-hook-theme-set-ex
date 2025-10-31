#!/bin/bash

output_file="$HOME/.config/omarchy/current/theme/zed.json"

if ! command -v zeditor >/dev/null 2>&1; then
    warning "Zed not found. Install 'zed' to use.."
    exit 0
fi

if [[ ! -f "$output_file" ]]; then
    cat > "$output_file" << EOF
{
  "\$schema": "https://zed.dev/schema/themes/v0.1.0.json",
  "name": "Omarchy",
  "author": "@bypass_",
  "themes": [
    {
      "name": "Omarchy",
      "appearance": "dark",
      "style": {
        "background": "#${primary_background}90",
        "editor.background": "#${primary_background}90",
        "editor.foreground": "#${primary_foreground}",
        "text": "#${primary_foreground}",
        "text.muted": "#${primary_foreground}70",
        "text.ignored": "#${primary_foreground}40",
        "text.placeholder": "#${primary_foreground}50",
        "ignored": "#${primary_foreground}30",
        "element.hover": "#${primary_foreground}30",
        "ghost_element.hover": "#${bright_colors[black]}30",
        "ghost_element.selected": "#${bright_colors[black]}30",
        "ghost_element.active": "#${bright_colors[black]}60",
        "border": "#${normal_colors[black]}",
        "editor.highlighted_line.background": "#${bright_colors[black]}10",
        "editor.active_line.background": "#${bright_colors[black]}10",
        "panel.background": "#${normal_colors[black]}90",
        "title_bar.background": "#${normal_colors[black]}90",
        "title_bar.inactive_background": "#${normal_colors[black]}90",
        "status_bar.background": "#${normal_colors[black]}90",
        "drop_target.background": "#${normal_colors[black]}90",
        "elevated_surface.background": "#${normal_colors[black]}",
        "toolbar.background": "#${normal_colors[black]}90",
        "tab_bar.background": "#${normal_colors[black]}90",
        "tab.inactive_background": "#${normal_colors[black]}90",
        "tab.active_background": "#${bright_colors[black]}30",
        "scrollbar.track.background": "transparent",
        "scrollbar.track.border": "#${normal_colors[black]}",
        "scrollbar.thumb.background": "#${primary_foreground}",
        "editor.gutter.background": "#${normal_colors[black]}90",
        "terminal.background": "#${normal_colors[black]}10",
        "terminal.foreground": "#${primary_foreground}",
        "terminal.dim_foreground": "#${primary_foreground}",
        "terminal.bright_foreground": "#${primary_foreground}",
        "terminal.ansi.black": "#${normal_colors[black]}",
        "terminal.ansi.red": "#${normal_colors[red]}",
        "terminal.ansi.green": "#${normal_colors[green]}",
        "terminal.ansi.yellow": "#${normal_colors[yellow]}",
        "terminal.ansi.blue": "#${normal_colors[blue]}",
        "terminal.ansi.magenta": "#${normal_colors[magenta]}",
        "terminal.ansi.cyan": "#${normal_colors[cyan]}",
        "terminal.ansi.white": "#${normal_colors[white]}",
        "terminal.ansi.bright_black": "#${bright_colors[black]}",
        "terminal.ansi.bright_red": "#${bright_colors[red]}",
        "terminal.ansi.bright_green": "#${bright_colors[green]}",
        "terminal.ansi.bright_yellow": "#${bright_colors[yellow]}",
        "terminal.ansi.bright_blue": "#${bright_colors[blue]}",
        "terminal.ansi.bright_magenta": "#${bright_colors[magenta]}",
        "terminal.ansi.bright_cyan": "#${bright_colors[cyan]}",
        "terminal.ansi.bright_white": "#${bright_colors[white]}",
        "modified": "#${normal_colors[red]}",
        "syntax": {
          "attribute": {
            "color": "#${normal_colors[red]}"
          },
          "boolean": {
            "color": "#${normal_colors[green]}"
          },
          "comment": {
            "color": "#${bright_colors[black]}"
          },
          "comment.doc": {
            "color": "#${bright_colors[black]}"
          },
          "constant": {
            "color": "#${bright_colors[green]}"
          },
          "function": {
            "color": "#${bright_colors[cyan]}"
          },
          "keyword": {
            "color": "#${normal_colors[blue]}"
          },
          "number": {
            "color": "#${normal_colors[magenta]}"
          },
          "operator": {
            "color": "#${normal_colors[blue]}"
          },
          "string": {
            "color": "#${normal_colors[red]}"
          },
          "variable": {
            "color": "#${normal_colors[green]}"
          }
        },
        "players": [
          {
            "cursor": "#${primary_foreground}",
            "background": "#${normal_colors[black]}",
            "selection": "#${primary_foreground}30"
          }
        ]
      }
    }
  ]
}
EOF
fi

cp "$output_file" "$HOME/.config/zed/themes/omarchy.json"
