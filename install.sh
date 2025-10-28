#! /bin/bash

rm -rf /tmp/theme-hook/

git clone https://github.com/imbypass/omarchy-hook-theme-set-ex.git /tmp/theme-hook

mv /tmp/theme-hook/theme-set ~/.config/omarchy/hooks/

mkdir -p ~/.config/omarchy/hooks/theme-set.conf/
mv /tmp/theme-hook/theme-set.conf/* ~/.config/omarchy/hooks/theme-set.conf/

rm -rf /tmp/theme-hook

chmod +x ~/.config/omarchy/hooks/theme-set
chmod +x ~/.config/omarchy/hooks/theme-set.conf/*

omarchy-theme-set $(omarchy-theme-current)

omarchy-show-done
exit 0
