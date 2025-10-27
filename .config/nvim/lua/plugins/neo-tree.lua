return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        lazy = false,
        keys = {
            { "<leader><leader>", "<cmd>:Neotree reveal<cr>", desc = "File browser" },
        },
        opts = {
            window = {
                position = "current",
            },
            use_default_mappings = false,
            follow_current_file = {
                enabled = true,
                leave_dirs_open = false,
            },
            group_empty_dirs = true,
            sources = {
                "filesystem",
                "buffers",
                "git_status",
            },
            enable_git_status = true,
            enable_modified_markers = false,
            enable_opened_markers = false,
            enable_refresh_on_write = true,
            default_component_configs = {
                name = {
                    trailing_slash = true,
                },
                indent = {
                    with_expanders = true,
                    expander_collapsed = "",
                    expander_expanded = "",
                },
                icon = {
                    folder_closed = "󰉋",
                    folder_open = "󰉋",
                    folder_empty = "󰉖",
                    folder_empty_open = "󰉖",
                },
                modified = {
                    symbol = "",
                },
                git_status = {
                    symbols = {
                        -- Change type
                        added = "",
                        deleted = "",
                        modified = "",
                        renamed = "",
                        -- Status type
                        untracked = "",
                        ignored = "",
                        unstaged = "",
                        staged = "",
                        conflict = "󰕚",
                    },
                },
                file_size = {
                    enabled = true,
                    width = 18, -- width of the column
                    required_width = 64, -- min width of window required to show this column
                },
                type = {
                    enabled = true,
                    width = 18, -- width of the column
                    required_width = 122, -- min width of window required to show this column
                },
                last_modified = {
                    enabled = true,
                    width = 24, -- width of the column
                    required_width = 88, -- min width of window required to show this column
                },
                created = {
                    enabled = true,
                    width = 24, -- width of the column
                    required_width = 110, -- min width of window required to show this column
                },
                symlink_target = {
                    enabled = false,
                },
            },
            filesystem = {
                hijack_netrw_behavior = "open_current",
                scan_mode = "deep",
                filtered_items = {
                    show_hidden_count = true,
                    visible = true,
                    hide_dotfiles = true,
                    hide_ignored = true,
                    never_show = {
                        ".DS_Store",
                    },
                },
                window = {
                    mappings = {
                        ["<cr>"] = { "open", desc = "Open" },
                        ["<bs>"] = { "navigate_up", desc = "Navigate up" },
                        ["."] = { "set_root", desc = "Set root" },
                        ["H"] = { "toggle_hidden", desc = "Toggle hidden" },
                        ["a"] = { "add", desc = "Add", config = { show_path = "relative" } },
                        ["c"] = { "close_all_nodes", desc = "Close all nodes" },
                        ["d"] = { "delete", desc = "Delete" },
                        ["p"] = { "paste_from_clipboard", desc = "Paste from clipboard" },
                        ["P"] = { "toggle_preview", desc = "Toggle preview" },
                        ["r"] = { "rename", desc = "Rename" },
                        ["s"] = { "filter_as_you_type", desc = "Search" },
                        ["x"] = { "cut_to_clipboard", desc = "Cut to clipboard" },
                        ["y"] = { "copy_to_clipboard", desc = "Copy to clipboard" },
                        ["[s"] = { "prev_source", desc = "Previous source" },
                        ["]s"] = { "next_source", desc = "Next source" },
                    },
                },
            },
            buffers = {
                window = {
                    mappings = {
                        ["d"] = { "buffer_delete", desc = "Delete" },
                        ["P"] = { "toggle_preview", desc = "Toggle preview" },
                        ["r"] = { "rename", desc = "Rename" },
                        ["[s"] = { "prev_source", desc = "Previous source" },
                        ["]s"] = { "next_source", desc = "Next source" },
                    },
                },
            },
            git_status = {
                window = {
                    mappings = {
                        ["<cr>"] = { "open", desc = "Open" },
                        ["P"] = { "toggle_preview", desc = "Toggle preview" },
                        ["s"] = { "filter_as_you_type", desc = "Search" },
                        ["r"] = { "rename", desc = "Rename" },
                        ["[s"] = { "prev_source", desc = "Previous source" },
                        ["]s"] = { "next_source", desc = "Next source" },
                    },
                },
            },
        },
    },
    {
        "antosha417/nvim-lsp-file-operations",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-neo-tree/neo-tree.nvim",
        },
        config = true,
    },
}
