return {
    { "neovim/nvim-lspconfig" },
    {
        "mason-org/mason.nvim",
        config = true,
    },
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
