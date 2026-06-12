return {
    { "neovim/nvim-lspconfig" },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            automatic_enable = true,
        },
    },

    {
        "SmiteshP/nvim-navic",
        dependencies = {
            "neovim/nvim-lspconfig",
        },
        opts = {
            lsp = {
                auto_attach = true,
            },
        },
    },

    -- Specific LSPs
    {
        "seblyng/roslyn.nvim",
        ft = "cs",
        config = true,
    },
}
