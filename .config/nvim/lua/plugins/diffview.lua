return {
    {
        "sindrets/diffview.nvim",
        opts = {
            hooks = {
                diff_buf_read = function()
                    vim.opt_local.wrap = true
                    vim.opt_local.list = true
                end,
            },
        },
    },
}
