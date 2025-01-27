return {
    {
        "stevearc/oil.nvim",
        lazy = false,
        opts = {
            default_file_explorer = true,
            columns = {
                "icon",
                "size",
                "mtime",
            },
            watch_for_changes = true,
            view_options = {
                show_hidden = true,
                sort = {
                    { "name", "asc", },
                },
            },
        },
    },
}
