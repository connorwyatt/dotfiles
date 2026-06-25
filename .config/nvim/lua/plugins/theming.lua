local theming = require("helpers.theming")

return {
    {
        "connorwyatt/themes.nvim",
        priority = 10000,
    },

    {
        "f-person/auto-dark-mode.nvim",
        dependencies = {
            -- "xiyaowong/transparent.nvim",
        },
        init = function()
            theming.apply("dark")
            -- vim.cmd(":TransparentEnable")
        end,
        opts = {
            update_interval = 300000,
            set_dark_mode = function()
                theming.apply("dark")
            end,
            set_light_mode = function()
                theming.apply("light")
            end,
        },
    },
}
