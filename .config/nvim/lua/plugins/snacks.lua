local ivyOrIvySplitPickerLayout = function()
    return vim.o.columns >= 120 and "ivy" or "ivy_split"
end

local ivySplitPickerLayout = function()
    return "ivy_split"
end

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
                preset = ivyOrIvySplitPickerLayout,
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
            formatters = {
                file = {
                    filename_first = false,
                    truncate = "center",
                    filename_only = false,
                    icon_width = 2,
                    git_status_hl = true,
                },
            },
            sources = {
                files = { layout = { preset = ivySplitPickerLayout } },
                grep = { layout = { preset = ivySplitPickerLayout } },
                recent = { layout = { preset = ivySplitPickerLayout } },
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
    },
}
