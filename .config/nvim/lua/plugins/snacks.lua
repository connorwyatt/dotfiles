local ivyPickerLayout = function()
    return { preset = "ivy" }
end

local ivySplitPickerLayout = function()
    return { preset = "ivy_split" }
end

local ivyOrIvySplitPickerLayout = function()
    return vim.o.columns >= 120 and ivyPickerLayout() or ivySplitPickerLayout()
end

local defaultPickerLayout = function()
    return {
        layout = {
            box = "horizontal",
            width = 0.8,
            min_width = 120,
            height = 0.8,
            {
                box = "vertical",
                border = true,
                title = "{title} {live} {flags}",
                { win = "input", height = 1, border = "bottom" },
                { win = "list", border = "none" },
            },
            { win = "preview", title = "{preview}", border = true, width = 0.5 },
        },
    }
end

local verticalPickerLayout = function()
    return {
        layout = {
            backdrop = false,
            width = 0.5,
            min_width = 80,
            height = 0.8,
            min_height = 30,
            box = "vertical",
            border = true,
            title = "{title} {live} {flags}",
            title_pos = "center",
            { win = "input", height = 1, border = "bottom" },
            { win = "list", border = "none" },
            { win = "preview", title = "{preview}", height = 0.4, border = "top" },
        },
    }
end

local defaultOrVerticalPickerLayout = function()
    return vim.o.columns >= 120 and defaultPickerLayout() or verticalPickerLayout()
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
            layout = vim.tbl_deep_extend("force", {
                cycle = true,
            }, ivyOrIvySplitPickerLayout()),
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
                files = { layout = defaultOrVerticalPickerLayout() },
                grep = { layout = ivySplitPickerLayout() },
                recent = { layout = defaultOrVerticalPickerLayout() },
            },
        },
        quickfile = {
            enabled = true,
        },
        statuscolumn = {
            enabled = true,
            left = { "sign" },
            right = { "fold", "git" },
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
