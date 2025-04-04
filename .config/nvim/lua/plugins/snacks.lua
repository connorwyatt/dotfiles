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
            chunk = {
                enabled = true,
                char = {
                    arrow = "─",
                },
            },
        },
        input = {
            enabled = true,
        },
        notifier = {
            enabled = true,
        },
        picker = {
            enabled = true,
            ui_select = true,
            layout = {
                cycle = true,
                preset = "vertical",
            },
            matcher = {
                sort_empty = true,
                frecency = true,
            },
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
        styles = {
            float = {
                position = "float",
                backdrop = false,
            },
            input = {
                border = "single",
                relative = "cursor",
                -- row = -3,
                -- col = 0,
            },
            notification = {
                border = "single",
            },
            notification_history = {
                border = "single",
            },
        },
        words = {
            enabled = true,
            debounce = 0,
            modes = { "n" },
        },
    },
}
