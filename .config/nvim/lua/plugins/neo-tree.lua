return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    opts = {
        use_popups_for_input = false,
        window = {
            position = "current",
        },
        search_limit = 1000,
        follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
        },
        group_empty_dirs = true,
        use_default_mappings = false,
        filesystem = {
            scan_mode = "deep",
            window = {
                mappings = {
                    ["<cr>"] = { "open", desc = "Open", config = { expand_nested_files = true, }, },
                    ["<bs>"] = { "navigate_up", desc = "Navigate up", },
                    ["."] = { "set_root", desc = "Set root", },
                    ["a"] = { "add", desc = "Add", config = { show_path = "relative", }, },
                    ["b"] = { "rename_basename", desc = "Rename basename", },
                    ["c"] = { "close_all_nodes", desc = "Close all nodes", },
                    ["d"] = { "delete", desc = "Delete", },
                    ["s"] = { "filter_as_you_type", desc = "Search", },
                    ["p"] = { "paste_from_clipboard", desc = "Paste from clipboard", },
                    ["r"] = { "rename", desc = "Rename", },
                    ["x"] = { "cut_to_clipboard", desc = "Cut to clipboard", },
                    ["y"] = { "copy_to_clipboard", desc = "Copy to clipboard", },
                },
            },
        },
        git_status = {
            window = {
                mappings = {
                    ["<cr>"] = { "open", desc = "Open", config = { expand_nested_files = true, }, },
                    ["b"] = { "rename_basename", desc = "Rename basename", },
                    ["s"] = { "filter_as_you_type", desc = "Search", },
                    ["r"] = { "rename", desc = "Rename", },
                },
            },
        },
    },
}
