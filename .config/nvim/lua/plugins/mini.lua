return {
    {
        "nvim-mini/mini.animate",
        version = "*",
        config = function()
            local animate = require("mini.animate")
            local timing = animate.gen_timing.linear({ duration = 50, unit = "total" })
            animate.setup({
                cursor = {
                    timing = timing,
                },
                scroll = {
                    timing = timing,
                },
                resize = {
                    timing = timing,
                },
                open = {
                    timing = timing,
                },
                close = {
                    timing = timing,
                },
            })
        end,
    },
    {
        "nvim-mini/mini.cursorword",
        version = "*",
        config = true,
    },
    {
        "nvim-mini/mini.pairs",
        version = "*",
        config = true,
    },
    {
        "nvim-mini/mini.splitjoin",
        version = "*",
        config = true,
    },
}
