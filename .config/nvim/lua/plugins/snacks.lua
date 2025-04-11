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
            },
            matcher = {
                sort_empty = false,
                frecency = true,
            },
            layouts = {
                select = {
                    layout = {
                        relative = "cursor",
                        width = 80,
                        min_width = 0,
                        row = 1,
                    },
                },
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
                row = 1,
                column = 0,
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
