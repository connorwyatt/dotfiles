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
        "nvim-treesitter/nvim-treesitter",
        version = false,
        build = ":TSUpdate",
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            bigfile = { enabled = true },
            dim = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            lazygit = { enabled = true },
            notifier = {
                enabled = true,
                timeout = 3000,
                wrap = true,
            },
            quickfile = { enabled = true },
            scroll = { enabled = true },
        },
        keys = {
            { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
            { "<leader>gl", function() Snacks.lazygit() end,               desc = "Lazygit" },
            { "<c-/>",      function() Snacks.terminal() end,              desc = "Toggle Terminal" },
        },
        init = function()
            vim.api.nvim_create_autocmd("User", {
                pattern = "VeryLazy",
                callback = function()
                    -- Setup some globals for debugging (lazy-loaded)
                    _G.dd = function(...)
                        Snacks.debug.inspect(...)
                    end
                    _G.bt = function()
                        Snacks.debug.backtrace()
                    end
                    vim.print = _G.dd -- Override print to use snacks for `:=` command

                    Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
                    Snacks.toggle.diagnostics():map("<leader>ud")
                    Snacks.toggle.inlay_hints():map("<leader>uh")
                    Snacks.toggle.indent():map("<leader>ug")
                    Snacks.toggle.dim():map("<leader>uD")
                end,
            })
        end,
    },
    { "nvim-treesitter/nvim-treesitter-context" },
    { "windwp/nvim-ts-autotag" },
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
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
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
    { "hrsh7th/cmp-nvim-lsp-signature-help" },
    { "lukas-reineke/cmp-rg" },
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
    { "Decodetalkers/csharpls-extended-lsp.nvim" },
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
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },
    { "xiyaowong/transparent.nvim" },

    -- themes
    { "rose-pine/neovim" },
    { "EdenEast/nightfox.nvim" },
    { "olimorris/onedarkpro.nvim" },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000
    },
}
