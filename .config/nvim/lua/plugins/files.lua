return {
    {
        "stevearc/oil.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        keys = {
            { "<leader><leader>", "<cmd>:Oil<cr>", desc = "Files" },
        },
        lazy = false,
        cmd = "Oil",
        opts = {
            default_file_explorer = true,
            columns = {
                { "mtime" },
                { "size" },
                { "icon" },
            },
            watch_for_changes = true,
            use_default_keymaps = false,
            keymaps = {
                ["g?"] = { "actions.show_help", mode = "n" },
                ["<CR>"] = { "actions.select" },
                ["<C-p>"] = { "actions.preview", opts = { split = "belowright" } },
                ["<C-r>"] = { "actions.refresh" },
                ["-"] = { "actions.parent", mode = "n" },
                ["_"] = { "actions.open_cwd", mode = "n" },
                ["."] = { "actions.cd", mode = "n" },
                ["gs"] = { "actions.change_sort", mode = "n" },
                ["gx"] = { "actions.open_external" },
                ["g."] = { "actions.toggle_hidden", mode = "n" },
                ["<localleader>s."] = {
                    desc = "Files",
                    callback = function()
                        Snacks.picker.files({ cwd = require("oil").get_current_dir() })
                    end,
                    mode = "n",
                },
                ["<localleader>s/"] = {
                    desc = "Grep",
                    callback = function()
                        Snacks.picker.grep({ dirs = { require("oil").get_current_dir() } })
                    end,
                    mode = "n",
                },
            },
            view_options = {
                show_hidden = true,
                natural_order = false,
                sort = {
                    { "type", "asc" },
                    { "name", "asc" },
                },
                is_always_hidden = function(name)
                    return name == ".DS_Store"
                end,
            },
            float = {
                border = "single",
                preview_split = "right",
            },
            confirmation = {
                border = "single",
            },
            progress = {
                border = "single",
            },
            ssh = {
                border = "single",
            },
            keymaps_help = {
                border = "single",
            },
        },
    },
}
