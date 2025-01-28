return {
    { "neovim/nvim-lspconfig", },

    -- Stop LSPs after inactivity.
    {
        "hinell/lsp-timeout.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
        },
        init = function()
            vim.g.lspTimeoutConfig = {
                stopTimeout  = 1000 * 60 * 5,
                startTimeout = 0,
                silent       = true,
            }
        end
    },

    -- LSP Installation
    { "williamboman/mason.nvim", },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
    },

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
        'stevearc/conform.nvim',
        config = true,
    },
}
