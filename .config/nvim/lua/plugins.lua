return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
    {
        "zaldih/themery.nvim",
        lazy = false,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        version = false,
        build = ":TSUpdate",
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
    },
    {
        "mbbill/undotree"
    },
    { "ThePrimeagen/harpoon" },
    { "tpope/vim-fugitive" },
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            }
        },
    },
    { "pwntester/octo.nvim" },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
    },
    {
        "stevearc/oil.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
    },
    { "neovim/nvim-lspconfig" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/nvim-cmp" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "mfussenegger/nvim-dap" },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio"
        },
    },
    { "nvim-neotest/nvim-nio" },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
    },
    {
        "mrcjkb/rustaceanvim",
        version = "^5",
        lazy = false,
    },

    -- themes
    { "rose-pine/neovim" },
    { "folke/tokyonight.nvim" },
    { "EdenEast/nightfox.nvim" },
    { "olimorris/onedarkpro.nvim" },
    { "rebelot/kanagawa.nvim" },
    { "embark-theme/vim" },
    { "Shatur/neovim-ayu" },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
}
