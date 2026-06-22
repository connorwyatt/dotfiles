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
    },

    {
        "f-person/auto-dark-mode.nvim",
        dependencies = {
            "xiyaowong/transparent.nvim",
        },
        opts = {
            update_interval = 1000,
            set_dark_mode = function()
                local dark_mode_theme = "Rose Pine Moon"
                vim.api.nvim_set_option_value("background", "dark", {})
                vim.cmd("colorscheme " .. themes.get_theme_name(dark_mode_theme))
                -- vim.cmd(":TransparentEnable")
            end,
            set_light_mode = function()
                local light_mode_theme = "Rose Pine Dawn"
                vim.api.nvim_set_option_value("background", "light", {})
                vim.cmd("colorscheme " .. themes.get_theme_name(light_mode_theme))
                -- vim.cmd(":TransparentEnable")
            end,
        },
    },
}
