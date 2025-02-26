return {
    {
        "stevearc/oil.nvim",
        lazy = true,
        opts = {
            -- default_file_explorer = true,
            columns = {
                "icon",
                "size",
                "mtime",
            },
            watch_for_changes = true,
            use_default_keymaps = false,
            keymaps = {
                ["g?"] = { "actions.show_help", mode = "n" },
                ["<CR>"] = "actions.select",
                ["<C-p>"] = "actions.preview",
                ["<C-r>"] = "actions.refresh",
                ["-"] = { "actions.parent", mode = "n" },
                ["_"] = { "actions.open_cwd", mode = "n" },
                ["`"] = { "actions.cd", mode = "n" },
                ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
                ["gs"] = { "actions.change_sort", mode = "n" },
                ["gx"] = "actions.open_external",
                ["g."] = { "actions.toggle_hidden", mode = "n" },
                ["g\\"] = { "actions.toggle_trash", mode = "n" },
            },
            view_options = {
                show_hidden = true,
                sort = {
                    { "name", "asc", },
                },
            },
        },
    },
}
