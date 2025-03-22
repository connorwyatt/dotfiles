return {
    {
        "connorwyatt/sakura.nvim",
        dev = true,
        priority = 10000,
    },
    {
        "xiyaowong/transparent.nvim",
        opts = {
            exclude_groups = {
                "CursorLine",
                "CursorLineNr",
                "StatusLine",
            },
        },
        enabled = false,
    },
    {
        "f-person/auto-dark-mode.nvim",
        opts = {
            update_interval = 1000,
            set_dark_mode = function()
                local dark_mode_theme = "sakura-night"
                vim.api.nvim_set_option_value("background", "dark", {})
                vim.cmd("colorscheme " .. dark_mode_theme)
                -- vim.cmd(":TransparentEnable")
            end,
            set_light_mode = function()
                local light_mode_theme = "sakura-day"
                vim.api.nvim_set_option_value("background", "light", {})
                vim.cmd("colorscheme " .. light_mode_theme)
                -- vim.cmd(":TransparentEnable")
            end,
        },
    },
}
