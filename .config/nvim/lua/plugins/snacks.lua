return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        bigfile = {
            enabled = true,
            size = 2 * 1024 * 1024,
        },
        indent = {
            indent = {
                priority = 1,
                enabled = true,
                char = "│",
                only_scope = false,
                only_current = false,
                hl = "SnacksIndent",
            },
            scope = {
                enabled = true,
                priority = 200,
                char = "│",
                underline = false,
                only_current = false,
                hl = "SnacksIndentScope",
            },
        },
        notifier = {
            enabled = true,
        },
        quickfile = {
            enabled = true,
        },
        statuscolumn = {
            enabled = true,
            folds = {
                open = true,
            },
        },
        words = {
            enabled = true,
            debounce = 0,
            modes = { "n", },
        },
    },
}
