return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    opts = {
        use_popups_for_input = true,
        popup_border_style = "single",
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
        default_component_configs = {
            indent = {
                with_expanders = true,
                expander_collapsed = "",
                expander_expanded = "",
            },
            icon = {
                folder_closed = "",
                folder_open = "",
                folder_empty = "",
                folder_empty_open = "",
            },
            modified = {
                symbol = "",
            },
            git_status = {
                symbols = {
                    -- Change type
                    added     = " ",
                    deleted   = " ",
                    modified  = " ",
                    renamed   = " ",
                    -- Status type
                    untracked = "",
                    ignored   = "",
                    unstaged  = "",
                    staged    = "",
                    conflict  = " ",
                },
            },
        },
        filesystem = {
            scan_mode = "deep",
            filtered_items = {
                show_hidden_count = false,
                visible = true,
                never_show = {
                    ".DS_Store",
                },
            },
            window = {
                mappings = {
                    ["<cr>"] = { "open", desc = "Open", },
                    ["<bs>"] = { "navigate_up", desc = "Navigate up", },
                    ["."] = { "set_root", desc = "Set root", },
                    ["H"] = { "toggle_hidden", desc = "Toggle hidden", },
                    ["a"] = { "add", desc = "Add", config = { show_path = "relative", }, },
                    ["b"] = { "rename_basename", desc = "Rename basename", },
                    ["c"] = { "close_all_nodes", desc = "Close all nodes", },
                    ["d"] = { "delete", desc = "Delete", },
                    ["h"] = { "toggle_node", desc = "Toggle node", },
                    ["l"] = { "toggle_node", desc = "Toggle node", },
                    ["p"] = { "paste_from_clipboard", desc = "Paste from clipboard", },
                    ["r"] = { "rename", desc = "Rename", },
                    ["s"] = { "filter_as_you_type", desc = "Search", },
                    ["x"] = { "cut_to_clipboard", desc = "Cut to clipboard", },
                    ["y"] = { "copy_to_clipboard", desc = "Copy to clipboard", },
                },
            },
        },
        buffers = {
            window = {
                mappings = {
                    ["b"] = { "rename_basename", desc = "Rename basename", },
                    ["d"] = { "buffer_delete", desc = "Delete", },
                    ["r"] = { "rename", desc = "Rename", },
                },
            },
        },
        git_status = {
            window = {
                mappings = {
                    ["<cr>"] = { "open", desc = "Open", },
                    ["b"] = { "rename_basename", desc = "Rename basename", },
                    ["h"] = { "toggle_node", desc = "Toggle node", },
                    ["l"] = { "toggle_node", desc = "Toggle node", },
                    ["s"] = { "filter_as_you_type", desc = "Search", },
                    ["r"] = { "rename", desc = "Rename", },
                },
            },
        },
        nesting_rules = {
            ["*.cs"]             = {
                files = { "%1%.*%.cs", },
                pattern = "(.*)%.cs$"
            },
            ["appsettings.json"] = {
                files = { "appsettings%.*%.json", },
                pattern = "appsettings.json"
            },
            ["*.db"]             = {
                files = { "*%.db-shm", "*%.db-wal" },
                pattern = "(.*)%.db$"
            },
            ["*.tsx"]            = {
                files = { "%1-styles%.ts", },
                pattern = "(.*)%.tsx$"
            },
            [".gitignore"]       = {
                files = { "%.gitattributes", },
                pattern = "%.gitignore$"
            },
            ["Cargo.toml"]       = {
                files = { "%.rustfmt%.toml", "cargo%.lock", "Cargo%.lock", "rustfmt%.toml" },
                pattern = "Cargo%.toml$"
            },
            Dockerfile           = {
                files = { "dockerfile*", "*%.dockerfile", "%.dockerignore", "docker-compose%.*", },
                pattern = "Dockerfile$"
            },
            ["README.*"]         = {
                files = { "AUTHORS", "BACKERS*", "CHANGELOG*", "CITATION*", "CODE_OF_CONDUCT*", "CODEOWNERS", "CONTRIBUTING*", "CONTRIBUTORS", "COPYING*", "CREDITS", "GOVERNANCE%.MD", "HISTORY%.MD", "LICENSE*", "MAINTAINERS", "README_*", "RELEASE_NOTES*", "ROADMAP%.MD", "SECURITY%.MD", "SPONSORS*", "README-*" },
                ignore_case = true,
                pattern = "README%.(.*)$"
            },
            ["package.json"]     = {
                files = { "package-lock%.json", "%.eslint*", "%.prettier*", "eslint*", "prettier*", "tslint*", },
                pattern = "package%.json$"
            },
        },
    },
}
