#!/bin/bash

output_file="$HOME/.config/omarchy/current/theme/neovim.lua"

if [[ ! -f "$output_file" ]]; then
    cat > "$output_file" << EOF
return {
    {
        "bjarneo/aether.nvim",
        name = "aether",
        priority = 1000,
        opts = {
           	disable_italics = false,
           	colors = {
          		-- Monotone shades (base00-base07)
          		base00 = "${primary_background}", -- Default background
                base01 = "${bright_black}", -- Lighter background (status bars)
                base02 = "${normal_black}", -- Selection background
                base03 = "${bright_black}", -- Comments, invisibles
                base04 = "${normal_white}", -- Dark foreground
                base05 = "${foreground}", -- Default foreground
                base06 = "${bright_white}", -- Light foreground
                base07 = "${normal_white}", -- Light background

                -- Accent colors (base08-base0F)
                base08 = "${normal_red}", -- Variables, errors, red
                base09 = "${bright_red}", -- Integers, constants, orange
                base0A = "${normal_yellow}", -- Classes, types, yellow
                base0B = "${normal_green}", -- Strings, green
                base0C = "${normal_cyan}", -- Support, regex, cyan
                base0D = "${normal_blue}", -- Functions, keywords, blue
                base0E = "${normal_magenta}", -- Keywords, storage, magenta
                base0F = "${bright_yellow}", -- Deprecated, brown/yellow
           	},
        },
        config = function(_, opts)
            require("aether").setup(opts)
            vim.cmd.colorscheme("aether")

            -- Enable hot reload
            require("aether.hotreload").setup()
        end,
    },
    {
       	"LazyVim/LazyVim",
       	opts = {
      		colorscheme = "aether",
        },
    },
}
EOF
fi
