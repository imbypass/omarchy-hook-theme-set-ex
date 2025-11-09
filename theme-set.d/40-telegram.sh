#!/bin/bash

input_file="$HOME/.config/omarchy/current/theme/alacritty.toml"
output_file="$HOME/.local/share/TelegramDesktop/tdata/user_data/themes/omarchy.tdesktop-theme"

success() {
    echo -e "\e[32m[SUCCESS]\e[0m $1"
}

extract_from_section() {
    local section="$1"
    local color_name="$2"
    awk -v section="[$section]" -v color="$color_name" '
        $0 == section { in_section=1; next }
        /^\[/ { in_section=0 }
        in_section && $1 == color {
            if (match($0, /(#|0x)([0-9a-fA-F]{6})/)) {
                hex_part = substr($0, RSTART + (substr($0, RSTART, 2) == "0x" ? 2 : 1), 6)
                print "#" hex_part
                exit
            }
        }
    ' "$input_file"
}

create_dynamic_theme() {
    background=$(extract_from_section "colors.primary" "background")
    foreground=$(extract_from_section "colors.primary" "foreground")
    black=$(extract_from_section "colors.normal" "black")
    red=$(extract_from_section "colors.normal" "red")
    green=$(extract_from_section "colors.normal" "green")
    yellow=$(extract_from_section "colors.normal" "yellow")
    blue=$(extract_from_section "colors.normal" "blue")
    magenta=$(extract_from_section "colors.normal" "magenta")
    cyan=$(extract_from_section "colors.normal" "cyan")
    white=$(extract_from_section "colors.normal" "white")
    bright_black=$(extract_from_section "colors.bright" "black")
    bright_red=$(extract_from_section "colors.bright" "red")
    bright_green=$(extract_from_section "colors.bright" "green")
    bright_yellow=$(extract_from_section "colors.bright" "yellow")
    bright_blue=$(extract_from_section "colors.bright" "blue")
    bright_magenta=$(extract_from_section "colors.bright" "magenta")
    bright_cyan=$(extract_from_section "colors.bright" "cyan")
    bright_white=$(extract_from_section "colors.bright" "white")

    cat > "$output_file" << EOF
background: ${background};
text: ${foreground};
textLink: ${blue};
textLinkVisited: ${blue};
textSelectBg: ${bright_black};
textBold: ${foreground};
textItalic: ${foreground};
textCode: ${yellow};
textPre: ${yellow};
textPreBg: ${background};
textQuote: ${green};
textQuoteBg: ${background};
textMention: ${blue};
textMentionBg: ${bright_black};
textUrl: ${blue};
textUrlVisited: ${blue};
textSubtle: ${bright_black};
textInverse: ${background};
textInverseFg: ${foreground};
windowBg: ${background};
windowFg: ${foreground};
windowBgOver: ${background};
windowBgRipple: #ffffff20;
windowFgOver: ${foreground};
windowSubTextFg: ${bright_black};
windowBoldFg: ${foreground};
windowBgActive: ${background};
windowFgActive: ${foreground};
windowActiveTextFg: ${foreground};
windowShadowFg: #000000f0;
windowShadowFgFallback: #000000;
shadowFg: #00000000;
slideFadeOutBg: ${background};
slideFadeOutShadowFg: #00000000;
imageBg: #000000;
imageBgTransparent: #ffffff;
activeButtonBg: ${blue};
activeButtonBgOver: ${blue};
activeButtonBgRipple: ${blue};
activeButtonFg: ${background};
activeButtonFgOver: ${background};
activeButtonSecondaryFg: ${background};
activeButtonSecondaryFgOver: ${background};
buttonBg: ${background};
buttonBgOver: ${background};
buttonBgRipple: ${background};
buttonFg: ${foreground};
buttonFgOver: ${foreground};
buttonOutlineFg: ${blue};
buttonOutlineFgOver: ${blue};
buttonDefaultBg: ${blue};
buttonDefaultBgOver: ${blue};
buttonDefaultBgRipple: ${blue};
buttonDefaultFg: ${background};
buttonDefaultFgOver: ${background};
inputBg: ${background};
inputFg: ${foreground};
inputBgActive: ${background};
inputBgError: ${red};
inputBgErrorActive: ${red};
inputBorderFg: ${bright_black};
inputBorderFgActive: ${blue};
inputPlaceholderFg: ${bright_black};
inputPlaceholderFgActive: ${bright_black};
checkboxFg: ${bright_black};
radiobuttonFg: ${bright_black};
radiobuttonFgActive: ${blue};
scrollBarBg: ${background};
scrollBarBgOver: ${background};
scrollBg: ${background};
scrollBgOver: ${background};
scrollBgActive: ${blue};
scrollFg: ${bright_black};
scrollFgOver: ${bright_black};
scrollFgActive: ${bright_black};
smallCloseIconFg: ${bright_black};
smallCloseIconFgOver: ${bright_black};
radialFg: ${blue};
radialBg: ${background};
linkFg: ${blue};
linkFgOver: ${blue};
linkFgActive: ${blue};
linkFgVisited: ${blue};
titleBg: ${background};
titleShadow: #00000000;
titleBgActive: ${background};
titleFg: ${foreground};
titleFgActive: ${foreground};
trayCounterBg: ${red};
trayCounterBgMute: ${bright_black};
trayCounterFg: ${foreground};
trayCounterFgMute: ${foreground};
attentionButtonBg: ${red};
attentionButtonBgOver: ${red};
attentionButtonBgRipple: ${red};
attentionButtonFg: ${foreground};
attentionButtonFgOver: ${foreground};
attentionButtonBgOver: ${red}40;
attentionButtonBgRipple: #ffffff20;
attentionButtonFgRipple: ${foreground};
lightButtonBg: ${background};
lightButtonBgOver: ${background};
lightButtonBgRipple: ${background};
lightButtonFg: ${foreground};
lightButtonFgOver: ${foreground};
menuBg: ${background};
menuBgOver: ${background};
menuBgRipple: ${background};
menuFg: ${foreground};
menuFgOver: ${foreground};
menuSubmenuArrowFg: ${bright_black};
menuSubmenuArrowFgOver: ${bright_black};
dialogsBg: ${background};
dialogsBgOver: ${bright_black};
dialogsBgActive: ${bright_black};
dialogsNameFg: ${foreground};
dialogsTextFg: ${bright_black};
dialogButtonBg: ${background};
dialogButtonBgOver: ${background};
dialogButtonBgRipple: ${background};
dialogButtonFg: ${foreground};
dialogButtonFgOver: ${foreground};
dialogInputBg: ${background};
dialogInputFg: ${foreground};
dialogOutlineFg: ${blue};
dialogOutlineFgOver: ${blue};
dialogOutlineFgActive: ${blue};
dialogRatingFg: ${blue};
dialogFgError: ${red};
dialogBgError: ${red};
dialogOutlineFgError: ${red};
dialogShadowFg: ${background};
dialogShadowFgFallback: ${background};
separatorFg: ${bright_black};
separatorFgWeak: ${background};
placeholderFg: ${bright_black};
placeholderFgActive: ${bright_black};
historyTextInFg: ${foreground};
historyTextInFgSelected: ${foreground};
historyTextOutFg: ${foreground};
historyTextOutFgSelected: ${foreground};
historyLinkInFg: ${blue};
historyLinkInFgSelected: ${blue};
historyLinkOutFg: ${blue};
historyLinkOutFgSelected: ${blue};
historyFileInIconFg: ${blue};
historyFileInIconFgSelected: ${blue};
historyFileOutIconFg: ${blue};
historyFileOutIconFgSelected: ${blue};
historyFileInThumbFg: ${background};
historyFileInThumbFgSelected: ${background};
historyFileOutThumbFg: ${background};
historyFileOutThumbFgSelected: ${background};
historyCallIconFg: ${blue};
historyCallIconFgSelected: ${blue};
historyCallAnswerBg: ${green};
historyCallAnswerFg: ${background};
historyCallAnswerBgSelected: ${green};
historyCallAnswerFgSelected: ${background};
historyCallCancelBg: ${red};
historyCallCancelFg: ${foreground};
historyCallCancelBgSelected: ${red};
historyCallCancelFgSelected: ${foreground};
historyForwardChooseBg: ${background};
historyForwardChooseFg: ${foreground};
historyForwardChooseBgOver: ${background};
historyForwardChooseFgOver: ${foreground};
historyForwardChooseBgActive: ${blue};
historyForwardChooseFgActive: ${background};
historyPeer1NameFg: ${blue};
historyPeer1NameFgSelected: ${blue};
historyPeer1UserpicBg: ${blue};
historyPeer1UserpicBg2: ${blue};
historyPeer2NameFg: ${blue};
historyPeer2NameFgSelected: ${blue};
historyPeer2UserpicBg: ${blue};
historyPeer2UserpicBg2: ${blue};
historyPeer3NameFg: ${blue};
historyPeer3NameFgSelected: ${blue};
historyPeer3UserpicBg: ${blue};
historyPeer3UserpicBg2: ${blue};
historyPeer4NameFg: ${blue};
historyPeer4NameFgSelected: ${blue};
historyPeer4UserpicBg: ${blue};
historyPeer4UserpicBg2: ${blue};
historyPeer5NameFg: ${blue};
historyPeer5NameFgSelected: ${blue};
historyPeer5UserpicBg: ${blue};
historyPeer5UserpicBg2: ${blue};
historyPeer6NameFg: ${blue};
historyPeer6NameFgSelected: ${blue};
historyPeer6UserpicBg: ${blue};
historyPeer6UserpicBg2: ${blue};
historyPeer7NameFg: ${blue};
historyPeer7NameFgSelected: ${blue};
historyPeer7UserpicBg: ${blue};
historyPeer7UserpicBg2: ${blue};
historyPeer8NameFg: ${blue};
historyPeer8NameFgSelected: ${blue};
historyPeer8UserpicBg: ${blue};
historyPeer8UserpicBg2: ${blue};
historyPeerUserpicFg: ${foreground};
historyPeerUserpicFgSelected: ${foreground};
historyScrollBarBg: ${background};
historyScrollBarBgOver: ${background};
historyScrollFg: ${bright_black};
historyScrollFgOver: ${bright_black};
historyScrollFgActive: ${bright_black};
msgInBg: ${background};
msgInBgSelected: ${background};
msgOutBg: ${background};
msgOutBgSelected: ${background};
msgInFg: ${foreground};
msgInFgSelected: ${foreground};
msgOutFg: ${foreground};
msgOutFgSelected: ${foreground};
msgInMonoFg: ${yellow};
msgInMonoFgSelected: ${yellow};
msgOutMonoFg: ${yellow};
msgOutMonoFgSelected: ${yellow};
msgInBgBubble: ${background};
msgInBgBubbleSelected: ${background};
msgOutBgBubble: ${background};
msgOutBgBubbleSelected: ${background};
msgInFgBubble: ${foreground};
msgInFgBubbleSelected: ${foreground};
msgOutFgBubble: ${foreground};
msgOutFgBubbleSelected: ${foreground};
msgInDateFg: ${blue}cc;
msgInDateFgSelected: ${bright_black}90;
msgOutDateFg: ${blue}cc;
msgOutDateFgSelected: ${bright_black}90;
msgInReplyBarColor: ${blue};
msgInReplyBarColorSelected: ${blue};
msgOutReplyBarColor: ${blue};
msgOutReplyBarColorSelected: ${blue};
msgInReplyBarFg: ${foreground};
msgInReplyBarFgSelected: ${foreground};
msgOutReplyBarFg: ${foreground};
msgOutReplyBarFgSelected: ${foreground};
msgImgReplyBarColor: ${blue};
msgImgReplyBarColorSelected: ${blue};
msgImgReplyBarFg: ${foreground};
msgImgReplyBarFgSelected: ${foreground};
msgInServiceFg: ${bright_black};
msgInServiceFgSelected: ${bright_black};
msgOutServiceFg: ${bright_black};
msgOutServiceFgSelected: ${bright_black};
msgInShadow: #00000000;
msgOutShadow: #00000000;
msgInShadowSelected: #00000000;
msgOutShadowSelected: #00000000;
msgInDateFgBubble: ${bright_black};
msgInDateFgBubbleSelected: ${bright_black};
msgOutDateFgBubble: ${bright_black};
msgOutDateFgBubbleSelected: ${bright_black};
msgWaveformInFg: ${blue};
msgWaveformInFgSelected: ${blue};
msgWaveformOutFg: ${blue};
msgWaveformOutFgSelected: ${blue};
msgWaveformInActive: ${blue};
msgWaveformInActiveSelected: ${blue};
msgWaveformOutActive: ${blue};
msgWaveformOutActiveSelected: ${blue};
msgBotKbBg: ${background};
msgBotKbFg: ${foreground};
msgBotKbOverBgAdd: ${blue};
msgBotKbOverFg: ${background};
msgFileThumbFg: ${background};
msgFileThumbFgSelected: ${background};
msgFileInBg: ${background};
msgFileInBgSelected: ${background};
msgFileOutBg: ${background};
msgFileOutBgSelected: ${background};
msgFileInFg: ${foreground};
msgFileInFgSelected: ${foreground};
msgFileOutFg: ${foreground};
msgFileOutFgSelected: ${foreground};
msgFileInBgBubble: ${background};
msgFileInBgBubbleSelected: ${background};
msgFileOutBgBubble: ${background};
msgFileOutBgBubbleSelected: ${background};
msgFileInFgBubble: ${foreground};
msgFileInFgBubbleSelected: ${foreground};
msgFileOutFgBubble: ${foreground};
msgFileOutFgBubbleSelected: ${foreground};
msgFile1Bg: ${blue};
msgFile1BgDark: ${blue};
msgFile1BgSelected: ${blue};
msgFile1Fg: ${background};
msgFile1FgSelected: ${background};
msgFile2Bg: ${green};
msgFile2BgDark: ${green};
msgFile2BgSelected: ${green};
msgFile2Fg: ${background};
msgFile2FgSelected: ${background};
msgFile3Bg: ${yellow};
msgFile3BgDark: ${yellow};
msgFile3BgSelected: ${yellow};
msgFile3Fg: ${background};
msgFile3FgSelected: ${background};
msgFile4Bg: ${magenta};
msgFile4BgDark: ${magenta};
msgFile4BgSelected: ${magenta};
msgFile4Fg: ${background};
msgFile4FgSelected: ${background};
historyToDownBg: ${background}cc;
historyToDownBgOver: ${background};
historyToDownBgRipple: ${background};
historyToDownFg: ${bright_black};
historyToDownFgOver: ${bright_black};
historyToDownShadow: #00000000;
historyComposeAreaBg: ${background};
historyComposeAreaFg: ${foreground};
historyComposeAreaFgService: ${bright_black};
historyComposeIconFg: ${bright_black};
historyComposeIconFgOver: ${bright_black};
historySendIconFg: ${bright_black};
historySendIconFgOver: ${bright_black};
historyPinnedBg: ${background};
historyComposeButtonBg: ${blue};
historyComposeButtonBgOver: ${blue};
historyComposeButtonBgRipple: ${blue};
historyComposeButtonFg: ${background};
historyComposeButtonFgOver: ${background};
historyRecordBg: ${red};
historyRecordBgActive: ${red};
historyRecordFg: ${foreground};
historyRecordFgActive: ${foreground};
historyReplyBg: ${background};
historyReplyFg: ${foreground};
historyReplyIconFg: ${blue};
historyReplyCancelFg: ${bright_black};
historyReplyCancelFgOver: ${bright_black};
playerBg: ${background};
playerBgPlay: ${background};
playerBgPlayOver: ${background};
playerBgPlayActive: ${blue};
playerBgPause: ${background};
playerBgPauseOver: ${background};
playerBgPauseActive: ${blue};
playerFg: ${foreground};
playerFgActive: ${foreground};
playerPlayFg: ${foreground};
playerPlayFgOver: ${foreground};
playerPlayFgActive: ${background};
playerPauseFg: ${foreground};
playerPauseFgOver: ${foreground};
playerPauseFgActive: ${background};
overviewBg: ${background};
overviewFg: ${foreground};
overviewFgActive: ${foreground};
overviewPreviewBg: ${background};
overviewPreviewFg: ${foreground};
overviewIconFg: ${bright_black};
overviewIconFgActive: ${blue};
profileStatusFgOver: ${blue};
profileVerifiedCheckFg: ${green};
profileAdminStartFg: ${blue};
profileAdminStartBg: ${background};
notificationsBg: ${background};
notificationsBgActive: ${background};
notificationsBgOver: ${background};
notificationsFg: ${foreground};
notificationsFgActive: ${foreground};
notificationsFgOver: ${foreground};
notificationSampleUserpicFg: ${blue};
notificationSampleCloseFg: ${bright_black};
notificationSampleCloseFgOver: ${bright_black};
notificationSampleTextFg: ${foreground};
notificationSampleNameFg: ${blue};
mainMenuBg: ${background};
mainMenuFg: ${foreground};
mainMenuBgOver: ${background};
mainMenuFgOver: ${foreground};
mainMenuBgActive: ${blue};
mainMenuFgActive: ${background};
mediaPlayerBg: ${background};
mediaPlayerActiveFg: ${blue};
mediaPlayerInactiveFg: ${bright_black};
mediaPlayerDisabledFg: ${bright_black};
mediaviewBg: ${background}e0;
mediaviewControlBg: ${background};
mediaviewControlFg: ${foreground};
mediaviewCaptionBg: ${background};
mediaviewCaptionFg: ${foreground};
mediaviewTextLinkFg: ${blue};
mediaviewSaveMsgBg: ${background};
mediaviewSaveMsgFg: ${foreground};
mediaviewPlaybackActive: ${blue};
mediaviewPlaybackInactive: ${bright_black};
mediaviewPlaybackDisabled: ${bright_black};
mediaviewTransparentBg: #000000;
mediaviewTransparentFg: #666666;
mediaviewBlurBg: ${background};
titleButtonBg: #00000000;
titleButtonFg: ${foreground};
titleButtonBgOver: #00000000;
titleButtonFgOver: ${foreground};
titleButtonBgActive: #00000000;
titleButtonFgActive: ${foreground};
titleButtonCloseBg: #00000000;
titleButtonCloseFg: ${bright_black};
titleButtonCloseBgOver: #00000000;
titleButtonCloseFgOver: ${red};
titleButtonCloseBgActive: #00000000;
titleButtonCloseFgActive: ${red};
filterInputBg: ${background};
filterInputFg: ${foreground};
filterInputActiveBg: ${background};
filterInputActiveFg: ${foreground};
filterInputInactiveBg: ${bright_black}20;
filterInputInactiveFg: ${bright_black};
filterInputBorderFg: ${bright_black};
filterInputBorderFgActive: ${blue};
filterInputBorderFgInactive: ${bright_black};
contactsBg: ${background};
contactsBgOver: ${background};
contactsFg: ${foreground};
contactsFgOver: ${foreground};
contactsStatusFg: ${bright_black};
contactsStatusFgOver: ${bright_black};
contactsStatusFgOnline: ${green};
contactsStatusFgOnlineOver: ${green};
panelBg: ${background};
panelBgOver: ${background};
panelBgActive: ${blue};
panelFg: ${foreground};
panelFgOver: ${foreground};
panelFgActive: ${background};
panelNameFg: ${foreground};
panelNameFgOver: ${foreground};
panelNameFgActive: ${background};
panelCallFg: ${blue};
panelCallFgOver: ${blue};
panelCallFgActive: ${blue};
panelCallBg: ${background};
panelCallBgOver: ${background};
panelCallBgActive: ${blue};
panelToDoFg: ${blue};
panelToDoFgOver: ${blue};
panelToDoFgActive: ${blue};
panelToDoBg: ${background};
panelToDoBgOver: ${background};
panelToDoBgActive: ${blue};
panelBgRipple: ${background};
panelFgRipple: ${foreground};
panelActiveBgRipple: ${blue};
panelActiveFgRipple: ${background};
panelBgRippleOver: ${background};
panelFgRippleOver: ${foreground};
panelActiveBgRippleOver: ${blue};
panelActiveFgRippleOver: ${background};
panelBgRippleActive: ${blue};
panelFgRippleActive: ${background};
panelActiveBgRippleActive: ${blue};
panelActiveFgRippleActive: ${background};
toastBg: ${background};
toastFg: ${foreground};
callBg: ${background};
callFg: ${foreground};
callNameFg: ${foreground};
callStatusFg: ${bright_black};
callMuteFg: ${bright_black};
callMuteFgOver: ${bright_black};
callMuteFgActive: ${red};
callBarBg: ${background};
callBarBgMuted: ${red};
callBarFg: ${foreground};
importantTooltipBg: ${red};
importantTooltipFg: ${foreground};
importantTooltipFgLink: ${foreground};
tooltipBg: ${bright_black}a0;
tooltipFg: ${foreground};
tooltipBorderFg: #00000000;
tooltipFgLink: ${blue};
layerBg: ${bright_black}66;
layerBgRipple: ${background};
layerFg: ${foreground};
layerFgRipple: ${foreground};
layerActionBg: ${blue};
layerActionBgOver: ${blue};
layerActionBgRipple: ${blue};
layerActionFg: ${background};
layerActionFgOver: ${background};
layerActionFgRipple: ${background};
layerActionOutlineFg: ${blue};
layerActionOutlineFgOver: ${blue};
layerActionOutlineFgActive: ${blue};
layerActionOutlineFgRipple: ${blue};
sideBarBg: ${background};
sideBarBgActive: ${bright_black};
sideBarBgRipple: #ffffff40;
sideBarTextFg: ${foreground};
sideBarTextFgActive: ${foreground};
sideBarIconFg: ${bright_black};
sideBarIconFgActive: ${blue};
sideBarBadgeBg: ${blue};
sideBarBadgeBgMuted: ${bright_black};
sideBarBadgeFg: ${foreground};
boxBg: ${background};
boxFg: ${foreground};
boxBgRipple: ${background};
boxFgRipple: ${foreground};
boxTitleFg: ${foreground};
boxSearchBg: ${background};
boxSearchFg: ${foreground};
boxSearchCancelBg: ${background};
boxSearchCancelFg: ${bright_black};
boxSearchCancelBgOver: ${background};
boxSearchCancelFgOver: ${bright_black};
boxSearchCancelBgActive: ${blue};
boxSearchCancelFgActive: ${background};
membersInviteFg: ${blue};
membersInviteFgOver: ${blue};
membersInviteFgActive: ${blue};
membersInvite1Fg: ${blue};
membersInvite2Fg: ${green};
membersInvite3Fg: ${yellow};
membersInvite4Fg: ${magenta};
membersInvite5Fg: ${cyan};
membersInvite6Fg: ${red};
membersInvite7Fg: ${bright_blue};
membersInvite8Fg: ${bright_green};
membersInvite1Bg: ${blue};
membersInvite2Bg: ${green};
membersInvite3Bg: ${yellow};
membersInvite4Bg: ${magenta};
membersInvite5Bg: ${cyan};
membersInvite6Bg: ${red};
membersInvite7Bg: ${bright_blue};
membersInvite8Bg: ${bright_green};
stickerPanBg: ${background};
stickerPanBgRipple: ${background};
stickerPanFg: ${foreground};
stickerPanDeleteBg: ${red}40;
stickerPanDeleteFg: ${foreground};
stickerPreviewBg: #00000000;
stickerPreviewFg: ${foreground};
mapPointBg: ${blue};
mapPointFg: ${background};
EOF
}

themes_dir="$HOME/.local/share/TelegramDesktop/tdata/user_data/themes"

if [ ! -d "$themes_dir" ]; then
    mkdir -p "$themes_dir"
fi

if [ -f "$output_file" ]; then
    rm -f "$output_file"
fi

themes_dir="$HOME/.local/share/TelegramDesktop/tdata/user_data/themes"

if [ ! -d "$themes_dir" ]; then
    mkdir -p "$themes_dir"
fi

if [ -f "$output_file" ]; then
    rm -f "$output_file"
fi

create_dynamic_theme

# Activate Telegram to bring it to front
dbus-send --session --dest=org.telegram.desktop --type=method_call /org/telegram/desktop org.freedesktop.Application.Activate 'a{sv}' '{}' > /dev/null 2>&1

# Notify user
if command -v notify-send >/dev/null 2>&1; then
    notify-send "Telegram Theme Updated" "The omarchy theme has been generated. Go to Settings > Chat Settings > Choose from file... and select omarchy.tdesktop-theme to apply it."
fi

success "Telegram theme updated! Theme file generated at $output_file. Telegram activated - apply the theme in settings."
exit 
