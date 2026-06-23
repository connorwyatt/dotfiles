local themes = require("helpers.themes")

return {
    {
        "connorwyatt/sakura.nvim",
        priority = 10000,
    },

    {
        "rose-pine/neovim",
        name = "rose-pine",
        priority = 10000,
        opts = {
            highlight_groups = {
                StatusLineModeCommand = { bg = "foam", fg = "overlay", bold = true },
                StatusLineModeCommandText = { bg = "NONE", fg = "foam", bold = true },
                StatusLineModeInsert = { bg = "gold", fg = "overlay", bold = true },
                StatusLineModeInsertText = { bg = "NONE", fg = "gold", bold = true },
                StatusLineModeNormal = { bg = "rose", fg = "overlay", bold = true },
                StatusLineModeNormalText = { bg = "NONE", fg = "rose", bold = true },
                StatusLineModeReplace = { bg = "love", fg = "overlay", bold = true },
                StatusLineModeReplaceText = { bg = "NONE", fg = "love", bold = true },
                StatusLineModeSelect = { bg = "love", fg = "overlay", bold = true },
                StatusLineModeSelectText = { bg = "NONE", fg = "love", bold = true },
                StatusLineModeTerminal = { bg = "iris", fg = "overlay", bold = true },
                StatusLineModeTerminalText = { bg = "NONE", fg = "iris", bold = true },
                StatusLineModeVisual = { bg = "pine", fg = "overlay", bold = true },
                StatusLineModeVisualText = { bg = "NONE", fg = "pine", bold = true },
            },
        },
    },

    {
        "f-person/auto-dark-mode.nvim",
        dependencies = {
            "xiyaowong/transparent.nvim",
        },
        opts = {
            update_interval = 1000,
            set_dark_mode = function()
                local dark_mode_theme = "Sakura Night"
                vim.api.nvim_set_option_value("background", "dark", {})
                vim.cmd("colorscheme " .. themes.get_theme_name(dark_mode_theme))
                -- vim.cmd(":TransparentEnable")
            end,
            set_light_mode = function()
                local light_mode_theme = "Sakura Day"
                vim.api.nvim_set_option_value("background", "light", {})
                vim.cmd("colorscheme " .. themes.get_theme_name(light_mode_theme))
                -- vim.cmd(":TransparentEnable")
            end,
        },
    },
}
