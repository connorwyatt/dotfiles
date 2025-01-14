-------------------------
-- BASIC CONFIGURATION --
-------------------------

-- Make space the leader key and backslash the local leader key.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Show line numbers.
vim.opt.number = true

-- Indentation.
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Don't wrap by default.
vim.opt.wrap = false

-- Highlight line that cursor is on.
vim.opt.cursorline = true

-- Enable mouse mode, useful for resizing splits.
vim.opt.mouse = "a"

-- Disable mode display, it's already in lualine.
vim.opt.showmode = false

-- Enable break indent.
vim.opt.breakindent = true

-- Disable swapfile and backup.
vim.opt.swapfile = false
vim.opt.backup = false

-- Save undo history and set location.
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term.
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default.
vim.opt.signcolumn = "yes"

-- Derease update time.
vim.opt.updatetime = 250

-- Preview replacements inline.
vim.opt.inccommand = "split"

-- Show at least 10 lines either side of cursor.
vim.opt.scrolloff = 10

vim.opt.termguicolors = true

-- Show invisible characters.
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Use treesitter for folding.
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99

----------------
-- KEYMAPPING --
----------------

-- Clear search highlights on escape.
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Use escape to exit terminal mode.
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<leader>qd", vim.diagnostic.setloclist, { desc = "Diagnostic quicklist" })
vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Show diagnostic overlay" })

-------------
-- PLUGINS --
-------------

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    checker = {
        enabled = true,
        -- One week
        frequency = 604800,
    },
    change_detection = {
        notify = false,
    },
    ui = {
        size = {
            width = 0.9,
            height = 0.9,
        },
    },
    spec = {
        { dir = "~/Code/sakura.nvim" },
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
            "nvim-treesitter/nvim-treesitter-textobjects",
            dependencies = {
                "nvim-treesitter/nvim-treesitter",
            },
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
                notifier = {
                    enabled = true,
                    timeout = 3000,
                    wrap = true,
                },
                quickfile = { enabled = true },
                scroll = {
                    enabled = true,
                    animate = {
                        duration = { step = 15, total = 100 },
                    },
                },
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

                        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>tw")
                        Snacks.toggle.diagnostics():map("<leader>td")
                        Snacks.toggle.inlay_hints():map("<leader>th")
                        Snacks.toggle.indent():map("<leader>ti")
                        Snacks.toggle.dim():map("<leader>tf")
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
        { "mbbill/undotree" },
        {
            "chentoast/marks.nvim",
            event = "VeryLazy",
        },
        {
            "lewis6991/gitsigns.nvim",
            opts = {
                signs = {
                    add = { text = '+' },
                    change = { text = '~' },
                    delete = { text = '_' },
                    topdelete = { text = '‾' },
                    changedelete = { text = '~' },
                },
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
        {
            "hrsh7th/nvim-cmp",
            dependencies = {
                "nvim-tree/nvim-web-devicons",
                "onsails/lspkind.nvim",
            }
        },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-nvim-lsp-signature-help" },
        { "hrsh7th/cmp-nvim-lsp-document-symbol" },
        { "hrsh7th/cmp-path" },
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
        { "stevearc/conform.nvim" },
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
        {
            "f-person/auto-dark-mode.nvim",
            opts = {
                update_interval = 1000,
                set_dark_mode = function()
                    vim.api.nvim_set_option_value("background", "dark", {})
                    vim.cmd("colorscheme sakura-night")
                end,
                set_light_mode = function()
                    vim.api.nvim_set_option_value("background", "light", {})
                    vim.cmd("colorscheme sakura-night")
                end,
            }
        },

        -- themes
        { "rose-pine/neovim",         name = "rose-pine.nvim" },
        { "EdenEast/nightfox.nvim" },
        { "olimorris/onedarkpro.nvim" },
        {
            "catppuccin/nvim",
            name = "catppuccin",
            priority = 1000
        },
    },
})
