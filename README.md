# Extending Omarchy Theme Set Hook

I couldn't come up with a cleaner way to share this, so we get a GitHub repo.

## Installation
Run the following command to install the hook extension:
```
curl -fsSL https://imbypass.github.io/omarchy-hook-theme-set-ex/install.sh | bash
```

## Requirements
Each of these scripts will have optional requirements that are needed in order to run properly. These requirements are listed below:
- Vesktop / Equibop / Vencord / Equicord *(if your client supports theming and isn't listed, please open an issue to get it added.)*
- Spicetify is needed to theme Spotify. *(Make sure this is installed before trying to use this.)*

These scripts will check your Omarchy theme for the existence of:
- Discord theme
- GTK theme

If they *do* exist, they will be copied to their proper folders, otherwise a new set of each will be
generated dynamically using the theme's Alacritty config and copied to their proper folders.
This has also been extended for apps like Spotify, where we dynamically create a theme for any Omarchy theme.
