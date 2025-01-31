return {
    { "neovim/nvim-lspconfig", },

    -- LSP Installation
    { "williamboman/mason.nvim", },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
    },

    -- Specific LSPs
    { "Hoffs/omnisharp-extended-lsp.nvim", },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "onsails/lspkind.nvim",
        },
    },
    {
        "hrsh7th/cmp-buffer",
        dependencies = {
            "hrsh7th/nvim-cmp",
        },
    },
    {
        "hrsh7th/cmp-nvim-lsp",
        dependencies = {
            "hrsh7th/nvim-cmp",
        },
    },
    {
        "hrsh7th/cmp-nvim-lsp-signature-help",
        dependencies = {
            "hrsh7th/nvim-cmp",
        },
    },
    {
        "hrsh7th/cmp-nvim-lsp-document-symbol",
        dependencies = {
            "hrsh7th/nvim-cmp",
        },
    },
    {
        "hrsh7th/cmp-path",
        dependencies = {
            "hrsh7th/nvim-cmp",
        },
    },
    {
        "hrsh7th/cmp-cmdline",
        dependencies = {
            "hrsh7th/nvim-cmp",
        },
    },

    -- Snippets
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
    },
    { "saadparwaiz1/cmp_luasnip", },

    -- Formatting
    {
        "stevearc/conform.nvim",
        config = true,
    },
    {
        "zapling/mason-conform.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "stevearc/conform.nvim",
        },
    },
}
