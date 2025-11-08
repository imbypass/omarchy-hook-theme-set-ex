
# Omarchy Theme Hook
A clean solution to extend your Omarchy theme to other apps.

These scripts will check your Omarchy theme for the existence of any extended theme files and will install them automatically for you when a theme is applied.
If a theme is applied that contains extended theme files, they will be copied to their proper folders.
If they do *not* exist, a new set of each will be generated dynamically using the theme's Alacritty config and copied to their proper folders.

## Preview
![Preview](https://0x0.st/K_yY.png)

## Themed Apps
- Discord
- GTK (Nautilus/Files)
- Spotify
- Zed
- VSCode (experimental)
- more coming soon!

## Installation
Run the following command to install the hook extension:
```
curl -fsSL https://imbypass.github.io/omarchy-theme-hook/install.sh | bash
```
## Requirements
Each of these scripts will have optional requirements that are needed in order to run properly. These requirements are listed below:
- Vesktop / Equibop / Vencord / Equicord *(if your client supports theming and isn't listed, please open an issue to get it added.)*
- Spicetify is needed to theme Spotify. *(Make sure this is installed before trying to use this.)*
- Zed is obviously needed otherwise, there would be no way to theme it.

## FAQ
#### My Discord isn't theming!
1. Make sure you are using an aftermarket Discord client, like Vencord, Equicord, or Vesktop.
2. Apply your desired theme in Omarchy.
3. Enable the Omarchy theme in Discord.

#### Spotify says it themed, but nothing changed!
1. Make sure that you *properly* installed Spicetify, including any permission edits that may need to be made for Linux systems.
2. See a [[note for Linux users]](https://spicetify.app/docs/advanced-usage/installation#note-for-linux-users).
3. Apply your desired theme in Omarchy.

#### I installed the hook, but none of my apps are theming!
1. The theme hook will generate and install themes, but not apply them.
2. You need to manually set the theme to "Omarchy" one time for each app that supports theming.

#### What if I encounter issues?
If you encounter any issues, please open an issue on the GitHub repository.

#### Will you share your waybar configuration?
It's on GitHub.
https://github.com/imbypass/omarchy-waybar-bepi
