#!/bin/bash

colors_file="$HOME/.config/omarchy/current/theme/colors.json"
output_file="$HOME/.config/omarchy/current/theme/vencord.theme.css" # TODO: THIS SHOULD USE THE CURRENT/THEME DIR
discord_clients=(
    "$HOME/.config/Vencord"
    "$HOME/.config/vesktop"
    "$HOME/.config/equipbop"
    "/var/lib/flatpak/app/com.discordapp.Discord"
    "/var/lib/flatpak/app/dev.vencord.Vesktop"
    "/var/lib/flatpak/app/io.github.equicord.equibop"
)

clean_color() {
    echo "$1" | sed "s/['\"]//g" | sed 's/#//g' | sed 's/0x//g' | sed 's/0X//g'
}

colors=(black red green yellow blue magenta cyan white)
declare -A normal_colors bright_colors

primary_background=$(clean_color "$(jq -r '.primary.background' $colors_file)")
primary_foreground=$(clean_color "$(jq -r '.primary.foreground' $colors_file)")
for color in "${colors[@]}"; do
    normal_colors[$color]=$(clean_color "$(jq -r ".normal.$color" $colors_file)")
    bright_colors[$color]=$(clean_color "$(jq -r ".bright.$color" $colors_file)")
done
font=$(omarchy-font-current)

if [[ ! -f "$output_file" ]]; then
    cat > "$output_file" << EOF
/**
* @name Omarchy
* @author @bypass_
* @version 0.1.0
* @description Follow Omarchy system theme.
* @source https://omarchy.org/
**/

:root {
    --base00: #${primary_background};
    --base01: color-mix(in srgb, #${primary_background} 100%, white);
    --base02: color-mix(in srgb, #${primary_background} 90%, white);
    --base03: color-mix(in srgb, #${primary_background} 80%, white);
    --base04: color-mix(in srgb, #${primary_background} 70%, white);
    --base05: #${bright_colors[white]};
    --base06: color-mix(in srgb, #${bright_colors[white]} 75%, white);
    --base07: color-mix(in srgb, #${bright_colors[white]} 70%, white);
    --base08: #${bright_colors[white]};
    --base09: #${normal_colors[yellow]};
    --base0A: #${bright_colors[yellow]};
    --base0B: #${normal_colors[green]};
    --base0C: #${normal_colors[cyan]};
    --base0D: #${normal_colors[blue]};
    --base0E: #${normal_colors[magenta]};
    --base0F: #${bright_colors[red]};

    --font: "${font}";
    --font-code: var(--font);
    --font-primary: var(--font);
    --font-display: var(--font);
    --font-heading: var(--font);

    --font-weight-light: 500;
    --font-weight-normal: 550;

    --font-weight-normal: 600;
    --font-weight-light: 500;
    --font-weight-medium: 600;
    --font-weight-semibold: 800;
    --font-weight-bold: 900;
}

.theme-light,
.theme-dark,
.theme-darker,
.theme-midnight,
.visual-refresh {
    --activity-card-background: var(--base01) !important;
    --background-accent: var(--base03) !important;
    --background-floating: var(--base02) !important;
    --background-mentioned-hover: var(--base03) !important;
    --background-mentioned: var(--base02) !important;
    --background-message-highlight: var(--base02) !important;
    --background-message-hover: var(--base02) !important;
    --background-mod-strong: var(--base02) !important;
    --background-modifier-accent: var(--base02) !important;
    --background-modifier-active: var(--base02) !important;
    --background-modifier-hover: var(--base01) !important;
    --background-modifier-selected: var(--base01) !important;
    --background-primary: var(--base01) !important;
    --background-secondary-alt: var(--base01) !important;
    --background-secondary: var(--base00) !important;
    --background-surface-highest: var(--base02) !important;
    --background-surface-higher: var(--base02) !important;
    --background-surface-high: var(--base02) !important;
    --background-tertiary: var(--base00) !important;
    --background-base-low: var(--base01) !important;
    --background-base-lower: var(--base00) !important;
    --background-base-lowest: var(--base00) !important;
    --background-base-tertiary: var(--base00) !important;
    --background-code: var(--base02) !important;
    --background-mod-subtle: var(--base01) !important;
    --bg-base-secondary: var(--base00) !important;
    --bg-base-tertiary: var(--base00) !important;
    --bg-brand: var(--base03) !important;
    --bg-mod-faint: var(--base01) !important;
    --bg-overlay-2: var(--base01) !important;
    --bg-overlay-3: var(--base01) !important;
    --bg-overlay-color-inverse: var(--base03) !important;
    --bg-surface-raised: var(--base02) !important;
    --bg-surface-overlay: var(--base00) !important;
    --black: var(--base00) !important;
    --blurple-50: var(--base0D) !important;
    --border-faint: var(--base02) !important;
    --border-subtle: var(--border-faint) !important;
    --brand-05a: var(--base01) !important;
    --brand-10a: var(--base01) !important;
    --brand-15a: var(--base01) !important;
    --brand-260: var(--base0D) !important;
    --brand-360: var(--base0D) !important;
    --brand-500: var(--base0D) !important;
    --brand-560: var(--base01) !important;
    --button-danger-background: var(--base08) !important;
    --button-danger-background-disabled: var(--base03) !important;
    --button-filled-brand-background: var(--base0D) !important;
    --button-filled-brand-background-hover: var(--base03) !important;
    --button-filled-brand-text: var(--base00) !important;
    --button-filled-brand-text-hover: var(--base05) !important;
    --button-outline-positive-border: var(--base0B) !important;
    --button-outline-danger-background-hover: var(--base08) !important;
    --button-outline-danger-border-hover: var(--base08) !important;
    --button-positive-background: var(--base0B) !important;
    --button-positive-background-disabled: var(--base03) !important;
    --button-positive-background-hover: var(--base03) !important;
    --button-secondary-background: var(--base02) !important;
    --button-secondary-background-disabled: var(--base03) !important;
    --button-secondary-background-hover: var(--base03) !important;
    --button-secondary-text: var(--base07) !important;
    --card-primary-bg: var(--base02) !important;
    --channel-icon: var(--base04) !important;
    --channels-default: var(--base03) !important;
    --channel-text-area-placeholder: var(--base03) !important;
    --channeltextarea-background: var(--base01) !important;
    --chat-background-default: var(--base01) !important;
    --chat-text-muted: var(--base03) !important;
    --checkbox-background-checked: var(--base0D) !important;
    --checkbox-border-checked: var(--base0D) !important;
    --checkbox-background-default: var(--base02) !important;
    --checkbox-border-default: var(--base03) !important;
    --control-brand-foreground-new: var(--base0D) !important;
    --control-brand-foreground: var(--base04) !important;
    --control-text-primary-default: var(--base00) !important;
    --control-background-primary-default: var(--base05) !important;
    --custom-notice-text: var(--base01) !important;
    --custom-poll-style-vote-percentage: var(--base04) !important;
    --deprecated-text-input-bg: var(--base01) !important;
    --deprecated-text-input-border: var(--base02) !important;
    --font-display: var(--font, "gg sans") !important;
    --font-headline: var(--font, "gg sans") !important;
    --font-primary: var(--font, "gg sans") !important;
    --green-330: var(--base0B) !important;
    --green-360: var(--base0B) !important;
    --green-300: var(--base0B) !important;
    --header-primary: var(--base04) !important;
    --header-secondary: var(--base04) !important;
    --home-background: var(--base00) !important;
    --info-warning-foreground: var(--base0A) !important;
    --input-background: var(--base02) !important;
    --input-border: var(--base03) !important;
    --input-placeholder-text: var(--base03) !important;
    --interactive-active: var(--base07) !important;
    --interactive-hover: var(--base07) !important;
    --interactive-muted: var(--base03) !important;
    --interactive-normal: var(--base08) !important;
    --mention-background: var(--base03) !important;
    --mention-foreground: var(--base07) !important;
    --menu-item-danger-active-bg: var(--base08) !important;
    --menu-item-danger-hover-bg: var(--base08) !important;
    --menu-item-default-hover-bg: var(--base03) !important;
    --message-reacted-background: var(--base02) !important;
    --message-reacted-text: var(--base05) !important;
    --modal-background: var(--base01) !important;
    --modal-footer-background: var(--base00) !important;
    --notice-background-positive: var(--base0B) !important;
    --notice-text-positive: var(--base01) !important;
    --notice-background-warning: var(--base0A) !important;
    --notice-text-warning: var(--base01) !important;
    --notice-background-negative: var(--base08) !important;
    --notice-text-negative: var(--base01) !important;
    --opacity-blurple-24: var(--base02) !important;
    --plum-23: var(--base02) !important;
    --polls-victor-fill: var(--base0B) !important;
    --profile-gradient-button-color: var(--base02) !important;
    --primary-130: var(--base05) !important;
    --primary-300: var(--base05) !important;
    --primary-500: var(--base02) !important;
    --primary-600: var(--base00) !important;
    --primary-630: var(--base01) !important;
    --primary-660: var(--base00) !important;
    --primary-700: var(--base01) !important;
    --primary-800: var(--base00) !important;
    --red-400: var(--base08) !important;
    --red-460: var(--base08) !important;
    --red-500: var(--base08) !important;
    --red-630: var(--base08) !important;
    --red: var(--base08) !important;
    --redesign-input-control-selected: var(--base0B) !important;
    --scrollbar-auto-thumb: var(--base00) !important;
    --scrollbar-auto-track: transparent;
    --scrollbar-thin-thumb: var(--base00) !important;
    --scrollbar-thin-track: transparent;
    --search-popout-option-fade: none;
    --search-popout-option-non-text-color: var(--base07) !important;
    --status-danger-background: var(--base08) !important;
    --status-danger: var(--base08) !important;
    --status-negative: var(--base08) !important;
    --status-positive-background: var(--base0B) !important;
    --status-positive-text: var(--base0B) !important;
    --status-positive: var(--base0B) !important;
    --status-success: var(--base0B) !important;
    --status-warning-background: var(--base03) !important;
    --status-warning: var(--base09) !important;
    --teal-430: var(--base0C) !important;
    --text-brand: var(--base05) !important;
    --text-default: var(--base07) !important;
    --text-feedback-positive: var(--base0B) !important;
    --text-feedback-negative: var(--base08) !important;
    --text-feedback-warning: var(--base09) !important;
    --text-feedback-success: var(--base0B) !important;
    --text-link: var(--base04) !important;
    --text-muted: var(--base03) !important;
    --text-negative: var(--base08) !important;
    --text-normal: var(--base0F) !important;
    --text-positive: var(--base0B) !important;
    --text-primary: var(--base08) !important;
    --text-secondary: var(--base04) !important;
    --text-tertiary: var(--base03) !important;
    --text-warning: var(--base09) !important;
    --textbox-markdown-syntax: var(--base05) !important;
    --theme-base-color: var(--base00) !important;
    --user-profile-overlay-background: var(--base01) !important;
    --white-100: var(--base05) !important;
    --white-200: var(--base05) !important;
    --white-500: var(--base05) !important;
    --white: var(--base0C) !important;
    --yellow-360: var(--base0A) !important;
    --yellow-300: var(--base0A) !important;
    --__lottieIconColor: var(--base03) !important;
}

/* Set custom font for messages too */
.messageContent_c19a55 {
    font-family: var(--font);
    font-weight: var(--font-weight-normal);
}

/* Cleaned up Add Friend button */
.addFriend__133bf {
    background-color: var(--base01) !important;
    color: var(--base04) !important;
}
.addFriend__133bf:hover {
    color: var(--base0D) !important;
}

/* Fix voice channel USRBG backgrounds */
div[class^="background_"] {
    background-color: transparent !important;
}

/*--- Default Color Swap ---*/
path[fill^="currentColor"],
svg[fill^="currentColor"],
rect[fill^="currentColor"] {
    fill: var(--base07) !important;
}

/*--- Selected Text Recolor ---*/
::selection {
    color: var(--base00);
    background: var(--base03);
}

/*--- Mention Interactive Hover Color ---*/
.mention.interactive:hover {
    background-color: var(--base04) !important;
}

/*--- Default Folder Color Recolor ---*/
.default__459fb {
    background-color: var(--base07) !important;
}

/*--- Discord Icon (Top Right) Recolor ---*/
.childWrapper__6e9f8 {
    background-color: var(--base02) !important;
}

/*--- Close Icon Path Recolor ---*/
svg[class^="closeIcon__"] path {
    fill: var(--base04) !important;
}

/*--- Listen Along Invite Recolor ---*/
.invite__4d3fa {
    background: var(--base01) !important;
    border-color: var(--base02) !important;
}

/*--- Activity Card Background Recolor ---*/
.card__73069 {
    background-color: var(--base01);
}

div[class^="bar__"] {
    background-color: var(--base01) !important;
    border-color: var(--base02) !important;
}
/*--- Voice Bar Text Recolor ---*/
.barText__7aaec {
    color: var(--base0B) !important;
}
.unreadIcon__7aaec {
    color: var(--base0B) !important;
}

/*--- New Messages Indicator Text Recolor ---*/
.unreadPull__908e2 {
    color: var(--base02) !important;
}

/*--- Mentions Bar Text Recolor ---*/
.mentionsBar__7aaec .barText__7aaec {
    color: var(--base05) !important;
}

/*--- Forum Background Recolor ---*/
.container_f369db {
    background-color: var(--bg-overlay-2);
}

/*--- Sidebar Icon Recolor ---*/
.circleIconButton__5bc7e {
    color: var(--base04);
}

/*--- Summaries Tag Icon Recolor ---*/
.summariesBetaTag_cf58b5 {
    color: var(--base03);
}

/*--- Folder Icon Recolor ---*/
div.folderIconWrapper__48112 {
    background-color: var(--base01) !important;
}

/*--- Unread Message Badge Text Color ---*/
.numberBadge__2b1f5,
.textBadge__2b1f5 {
    color: var(--base02) !important;
}

/*--- Typing Indicator Recolor ---*/
.dots__5ad89 {
    color: var(--base02) !important;
}

/*--- Other Voice Channel Background Recolor ---*/
.iconBadge__650eb {
    background-color: var(--base03);
}

/*--- Server Booster Icon Recolor ---*/
.premiumIcon__5d473 {
    color: var(--base0F);
}

/*--- Server Boost Progress Bar Recolor ---*/
.progress__0d0f9 {
    background: var(--base0F) !important;
}

/*--- Call Container Recolor ---*/
.callContainer_cb9592 {
    background-color: var(--base00);
}
.gradientContainer_bfe55a {
    background-image: var(--base00);
}

/*--- Store Gradient Recolors ---*/
.gradient_e9ef78 {
    background: var(--base01) !important;
}
.bannerGradient__955a3 {
    background: var(--base00) !important;
}

/*--- New Messages Summary Bar Recolor ---*/
.newMessagesBar__0f481 {
    background-color: var(--base03);

    button.barButtonAlt__0f481 {
        background-color: var(--base02) !important;
    }
}

/*--- Unread Messages Indicator Recolor ---*/
.unreadPill__908e2 {
    color: var(--base01);
}

/*--- Button Text Recolor ---*/
.lookFilled__201d5.colorGreen__201d5,
.lookFilled__201d5.colorRed__201d5 {
    color: var(--base00) !important;
}

/*--- Remove Folder Group Borders ---*/
.folderGroupBackground__48112 {
    border: none;
}

/*--- Increase Text Legibility ---*/
* {
    text-rendering: optimizeLegibility !important;
}

/*--- Codeblock Syntax Highlighting Recolor ---*/

.hljs-ansi-foreground-red {
    color: var(--base08) !important;
}
.hljs-ansi-foreground-green {
    color: var(--base0B) !important;
}
.hljs-ansi-foreground-yellow {
    color: var(--base0A) !important;
}
.hljs-ansi-foreground-blue {
    color: var(--base0D) !important;
}
.hljs-ansi-foreground-magenta {
    color: var(--base0E) !important;
}
.hljs-attr {
    color: var(--base06) !important;
}
.hljs-attribute {
    color: var(--base06) !important;
}
.hljs-number {
    color: var(--base06) !important;
}
.hljs-selector-class {
    color: var(--base06) !important;
}
.hljs-comment {
    color: var(--base03) !important;
}
.hljs-subst {
    color: var(--base0D) !important;
}
.hljs-selector-pseudo {
    color: var(--base0B) !important;
}
.hljs-section {
    color: var(--base0B) !important;
}
.hljs-keyword {
    color: var(--base08) !important;
}
.hljs-variable {
    color: var(--base08) !important;
}
.hljs-meta {
    color: var(--base03) !important;
}
.hljs-built_in {
    color: var(--base09) !important;
}
.hljs-string {
    color: var(--base0B) !important;
}
.hljs-title {
    color: var(--base0E) !important;
}

/*--- Visual Refresh Recolor ---*/
/*--- BIG WORK IN PROGRESS. DISCORD MADE SOME BIG CHANGES. ---*/
.visual-refresh {
    div[class^="autocomplete__"] {
        background-color: var(--base02) !important;
    }
    path[fill^="rgba(88, 101, 242, 1)"] {
        fill: var(--base0B) !important;
    }
    div[class^="topicsPillContainer"] {
        --bg-overlay-2: var(--base02) !important;
    }
    .tagPill__9a337 {
        background-color: var(--base00) !important;
    }
    .bg__960e4 {
        background: var(--base00) !important;
    }
    .header_f37cb1 {
        /* background-color: var(--base01) !important; */
    }
    .wrapper_ef3116 {
        background-color: var(--base00) !important;
    }
    .sidebar_c48ade {
        background-color: var(--base00) !important;
    }
    .searchBar__97492 {
        background-color: var(--base02) !important;
    }
    .channelTextArea_f75fb0 {
        background: var(--base01) !important;
    }
    .chatContent_f75fb0 {
        background-color: var(--base00) !important;
    }
    .members_c8ffbb,
    .member_c8ffbb {
        background: var(--base00) !important;
    }
    .voiceBar__7aaec {
        background-color: var(--base02) !important;
    }
    button.button__67645.redGlow__67645,
    span.button__67645.redGlow__67645 {
        background-color: var(--base02) !important;
    }

    .experimentButton_e131a9.buttonColor_e131a9.buttonActive_e131a9 {
        background-color: var(--base0B) !important;
        color: var(--base00) !important;
    }

    .selectedBackground_e681d1 {
        background-color: var(--base02) !important;
    }

    /*--- Status Icon Recolor (DO NOT DISTURB) ---*/
    svg[fill^="#d83a42"],
    rect[fill^="#d83a42"],
    path[fill^="#d83a42"],
    svg[fill^="#d83a41"],
    rect[fill^="#d83a41"],
    path[fill^="#d83a41"] {
        fill: var(--status-danger) !important;
    }
    /*--- Status Icon Recolor (IDLE) ---*/
    svg[fill^="#ca9654"],
    rect[fill^="#ca9654"],
    path[fill^="#ca9654"],
    svg[fill^="#cc954c"],
    rect[fill^="#cc954c"],
    path[fill^="#cc954c"] {
        fill: var(--status-warning) !important;
    }
    /*--- Status Icon Recolor (ONLINE) ---*/
    path[fill^="#43a25a"],
    svg[fill^="#43a25a"],
    rect[fill^="#43a25a"],
    path[fill^="#40a258"],
    svg[fill^="#40a258"],
    rect[fill^="#40a258"] {
        fill: var(--status-positive) !important;
    }
    /*--- Status Icon Recolor (OFFLINE) ---*/
    svg[fill^="#83838b"],
    rect[fill^="#83838b"],
    path[fill^="#83838b"],
    svg[fill^="#82838b"],
    rect[fill^="#82838b"],
    path[fill^="#82838b"] {
        fill: var(--base03) !important;
    }
}

/* --- Light Theme Fix? --- */
.theme-light {
    --base01: color-mix(in srgb, var(--base00) 95%, black) !important;
    --base02: color-mix(in srgb, var(--base00) 85%, black) !important;
    --base03: color-mix(in srgb, var(--base00) 80%, black) !important;
    --base04: color-mix(in srgb, var(--base00) 70%, black) !important;
    --base06: color-mix(in srgb, var(--base05) 95%, white) !important;
    --base07: color-mix(in srgb, var(--base05) 90%, white) !important;
}
EOF
fi

for client in "${discord_clients[@]}"; do
    if [ -d "$client" ]; then

        if [[ -f "$client/themes/vencord.theme.css" ]]; then
            rm "$client/themes/vencord.theme.css"
        fi
        cp -f "$output_file" "$client/themes/vencord.theme.css"

        for file in "$client/themes/*"; do
            if [ -f "$file" ]; then
                touch "$file"
            fi
        done
    fi
done
