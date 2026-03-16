return {
    { "neovim/nvim-lspconfig" },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            automatic_enable = true,
        },
    },

    -- Specific LSPs
    {
        "seblyng/roslyn.nvim",
        ft = "cs",
        config = true,
    },
}
