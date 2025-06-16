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
                preset = function()
                    return "vertical"
                end,
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
                    filename_first = true,
                    truncate = 120,
                    filename_only = false,
                    icon_width = 2,
                    git_status_hl = true,
                },
            },
            sources = {
                marks = {
                    actions = {
                        delmark = function(picker)
                            local cursor = picker.list.cursor
                            local deleted = {}
                            for _, it in ipairs(picker:selected({ fallback = true })) do
                                local ok = pcall(vim.api.nvim_del_mark, it.label)
                                if ok then
                                    table.insert(deleted, it)
                                end
                            end
                            picker:close()
                            local picker_new = Snacks.picker.marks()
                            picker_new.list:view(cursor - #deleted)
                        end,
                    },
                    win = {
                        input = {
                            keys = {
                                ["<C-x>"] = { "delmark", mode = { "i", "n" } },
                            },
                        },
                        list = {
                            keys = {
                                ["dd"] = { "delmark" },
                            },
                        },
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
            modes = { "n", "i" },
        },
    },
}
