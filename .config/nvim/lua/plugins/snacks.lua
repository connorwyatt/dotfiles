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
            animate = {
                enabled = vim.fn.has("nvim-0.10") == 1,
                style = "out",
                easing = "linear",
                duration = {
                    step = 20,
                    total = 500,
                },
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
        picker = {
            enabled = true,
            ui_select = true,
            matcher = {
                sort_empty = true,
                frecency = true,
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
        },
        words = {
            enabled = true,
        },
    },
}
