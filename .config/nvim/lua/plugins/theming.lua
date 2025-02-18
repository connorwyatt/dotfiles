return {
    {
        "connorwyatt/sakura.nvim",
    },
    {
        "xiyaowong/transparent.nvim",
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
}
