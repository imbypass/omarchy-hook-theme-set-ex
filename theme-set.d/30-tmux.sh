#!/bin/bash
# Tmux color sync - Uses exported color variables from main theme-set hook
# Applies theme directly to running sessions without modifying user config

# Use exported variables from main theme-set hook
# These come from alacritty.toml → kitty.conf → waybar.css (with fallbacks)
bg="#${primary_background:-000000}"
fg="#${primary_foreground:-ffffff}"
accent="#${bright_cyan:-$fg}"
muted="#${bright_black:-666666}"

# Only theme if tmux is running
if ! pgrep tmux >/dev/null; then
  exit 0
fi

# Apply theme directly to all tmux sessions using set-option
# This does NOT modify ~/.tmux.conf - only applies to running sessions
tmux set-option -g status-style "bg=$bg,fg=$fg" 2>/dev/null
tmux set-option -g pane-border-style "fg=$muted" 2>/dev/null
tmux set-option -g pane-active-border-style "fg=$accent" 2>/dev/null
tmux set-option -g window-status-format "#[fg=$muted] #I #W " 2>/dev/null
tmux set-option -g window-status-current-format "#[fg=$accent,bold] #I #W " 2>/dev/null
tmux set-option -g message-style "bg=$bg,fg=$accent" 2>/dev/null

success "Tmux colors synced"
