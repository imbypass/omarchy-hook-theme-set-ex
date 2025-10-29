#! /bin/bash

rm -rf /tmp/theme-hook/

git clone https://github.com/imbypass/omarchy-hook-theme-set-ex.git /tmp/theme-hook

mv -f /tmp/theme-hook/theme-set ~/.config/omarchy/hooks/

mkdir -p ~/.config/omarchy/hooks/theme-set.d/
mv -f /tmp/theme-hook/theme-set.d/* ~/.config/omarchy/hooks/theme-set.d/

rm -rf /tmp/theme-hook

chmod +x ~/.config/omarchy/hooks/theme-set
chmod +x ~/.config/omarchy/hooks/theme-set.d/*

omarchy-theme-set $(omarchy-theme-current)

omarchy-show-done
