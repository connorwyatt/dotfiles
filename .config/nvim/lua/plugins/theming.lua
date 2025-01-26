return {
    {
        "rose-pine/neovim",
        name = "rose-pine.nvim",
    },
    {
        "xiyaowong/transparent.nvim",
        enabled = false,
        opts = {
            exclude_groups = {
                "CursorLine",
                "CursorLineNr",
            },
            extra_groups = {
                "NeoTree",
                "lualine_c",
                "lualine_x",
            },
        },
    },
    {
        "f-person/auto-dark-mode.nvim",
        opts = {
            update_interval = 1000,
            set_dark_mode = function()
                vim.api.nvim_set_option_value("background", "dark", {})
                vim.cmd("colorscheme rose-pine-moon")
            end,
            set_light_mode = function()
                vim.api.nvim_set_option_value("background", "light", {})
                vim.cmd("colorscheme rose-pine-dawn")
            end,
        },
    }
}
