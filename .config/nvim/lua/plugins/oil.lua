return {
    {
        "stevearc/oil.nvim",
        lazy = false,
        enabled = false,
        opts = {
            columns = {
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
