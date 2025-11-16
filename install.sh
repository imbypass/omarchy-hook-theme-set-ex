#! /bin/bash

set -e

omarchy-show-logo

rm -rf /tmp/theme-hook/

echo -e "Cloning Omarchy theme hook repository.."
git clone https://github.com/imbypass/omarchy-hook-theme-set-ex.git /tmp/theme-hook > /dev/null

mv -f /tmp/theme-hook/install.sh $HOME/.local/share/omarchy/bin/theme-hook-update
chmod +x $HOME/.local/share/omarchy/bin/theme-hook-update

mv -f /tmp/theme-hook/theme-set $HOME/.config/omarchy/hooks/

mkdir -p $HOME/.config/omarchy/hooks/theme-set.d/
mv -f /tmp/theme-hook/theme-set.d/* $HOME/.config/omarchy/hooks/theme-set.d/

rm -rf /tmp/theme-hook

chmod +x $HOME/.config/omarchy/hooks/theme-set
chmod +x $HOME/.config/omarchy/hooks/theme-set.d/*

echo "Executing theme hook.."
omarchy-theme-set "$(omarchy-theme-current)"

omarchy-show-done
