
# Omarchy Theme Hook
A clean solution to extend your Omarchy theme to other apps.

## Preview
![Preview](https://0x0.st/K_yY.png)

## Installation
Run the following command to install the hook extension:
```
curl -fsSL https://imbypass.github.io/omarchy-hook-theme-set-ex/install.sh | bash
```
## Requirements
Each of these scripts will have optional requirements that are needed in order to run properly. These requirements are listed below:
- Vesktop / Equibop / Vencord / Equicord *(if your client supports theming and isn't listed, please open an issue to get it added.)*
- Spicetify is needed to theme Spotify. *(Make sure this is installed before trying to use this.)*
- Zed is obviously needed otherwise, there would be no way to theme it. 😅

These scripts will check your Omarchy theme for the existence of:
- Discord theme
- GTK theme

If they *do* exist, they will be copied to their proper folders, otherwise a new set of each will be
generated dynamically using the theme's Alacritty config and copied to their proper folders.
This has also been extended for apps like Spotify, where we dynamically create a theme for any Omarchy theme.

## FAQ
#### My Discord isn't theming!
1. Make sure you are using an aftermarket Discord client, like Vencord, Equicord, or Vesktop.
2. Apply your desired theme in Omarchy.
3. Enable the Omarchy theme in Discord.

#### Spotify says it themed, but nothing changed!
1. Make sure that you *properly* installed Spicetify, including any permission edits that may need to be made for Linux systems.
2. See a [[note for Linux users]](https://spicetify.app/docs/advanced-usage/installation#note-for-linux-users).
3. Apply your desired theme in Omarchy.

#### What if I encounter issues?
If you encounter any issues, please open an issue on the GitHub repository.

#### Can I have your waybar config?
It's on GitHub.
https://github.com/imbypass/bepi-omarchy-waybar
