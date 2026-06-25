return {
    {
        "connorwyatt/themes.nvim",
        priority = 10000,
        dev = true,
    },

    {
        "f-person/auto-dark-mode.nvim",
        dependencies = {
            -- "xiyaowong/transparent.nvim",
        },
        opts = {
            update_interval = 300000,
            set_dark_mode = function()
                local dark_mode_theme = ""
                vim.api.nvim_set_option_value("background", "dark", {})
                vim.cmd("colorscheme " .. dark_mode_theme)
                -- vim.cmd(":TransparentEnable")
            end,
            set_light_mode = function()
                local light_mode_theme = "rose-pineish-dawn"
                vim.api.nvim_set_option_value("background", "light", {})
                vim.cmd("colorscheme " .. light_mode_theme)
                -- vim.cmd(":TransparentEnable")
            end,
        },
    },
}
