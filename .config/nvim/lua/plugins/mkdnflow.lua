local default_enabled = false

return {
    {
        "jakewvincent/mkdnflow.nvim",
        enabled = function()
            return vim.tbl_get(_G, "cw", "plugins", "mkdnflow", "enabled") or default_enabled
        end,
        opts = {
            path_resolution = {
                primary = "current",
            },
        },
    },
}
