# Extending Omarchy Theme Set Hook

I couldn't come up with a cleaner way to share this, so we get a GitHub repo.
Copy these files to `~/.config/omarchy/hooks/` and make sure they are executable (chmod +x)

These scripts will check your Omarchy theme for the existence of:
- Discord theme
- GTK theme
- Foot Terminal theme

If they *do* exist, they will be copied to their proper folders, otherwise a new set of each will be
generated dynamically using the theme's Alacritty config and copied to their proper folders.

This can also be extended further as well, just drop any scripts you want executed into `theme-set.conf`
and they will get executed when `theme-set` is executed. In my personal setup, I have a Firefox theme
and my keyboard RGB lights set to change as well.
