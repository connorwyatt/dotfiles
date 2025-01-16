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

-- Disable arrow keys in normal mode.
vim.keymap.set("n", "<left>", "<cmd>echo 'Use h to move!!'<CR>")
vim.keymap.set("n", "<right>", "<cmd>echo 'Use l to move!!'<CR>")
vim.keymap.set("n", "<up>", "<cmd>echo 'Use k to move!!'<CR>")
vim.keymap.set("n", "<down>", "<cmd>echo 'Use j to move!!'<CR>")

-- Split keybinds.
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left split" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right split" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower split" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper split" })

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
        { "tpope/vim-surround" },
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
                "nvim-lua/plenary.nvim",
                {
                    "nvim-telescope/telescope-fzf-native.nvim",
                    build = "make",
                    cond = function()
                        return vim.fn.executable "make" == 1
                    end,
                },
                { "nvim-telescope/telescope-ui-select.nvim" },
            },
            config = function()
                local dropdown = {
                    results_title = false,
                    sorting_strategy = "ascending",
                    prompt_position = "top",
                    layout_strategy = "center",
                    layout_config = {
                        prompt_position = "top",
                        anchor = "N",
                        preview_cutoff = 1,

                        width = function(_, max_columns, _)
                            return math.min(max_columns, 120)
                        end,

                        height = function(_, _, max_lines)
                            return math.min(max_lines, 15)
                        end,
                    },
                    border = true,
                    borderchars = {
                        prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
                        results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
                        preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                    },
                }

                local ivy = {
                    sorting_strategy = "ascending",

                    layout_strategy = "bottom_pane",
                    layout_config = {
                        height = 25,
                    },

                    border = true,
                    borderchars = {
                        prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
                        results = { " " },
                        preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                    },
                }

                require("telescope").setup {
                    defaults = dropdown,
                    extensions = {
                        ["ui-select"] = {
                            require("telescope.themes").get_dropdown(),
                        },
                    },
                }

                require("telescope").load_extension("fzf")
                require("telescope").load_extension("ui-select")

                local builtin = require("telescope.builtin")
                vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
                vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Find git files" })
                vim.keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "Find live grep" })
                vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
                vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help tags" })
                vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Find recent files" })
                vim.keymap.set("n", "<leader>ft", builtin.treesitter, { desc = "Find treesitter" })
                vim.keymap.set("n", "<leader>fd", builtin.lsp_document_symbols, { desc = "Find LSP document symbols" })
                vim.keymap.set("n", "<leader>fw", builtin.lsp_dynamic_workspace_symbols,
                    { desc = "Find LSP workspace symbols" })
                vim.keymap.set("n", "<leader>fj", builtin.jumplist, { desc = "Find jumplist" })
                vim.keymap.set("n", "<leader>fc", builtin.current_buffer_fuzzy_find, { desc = "Find in open buffer" })
            end,
        },
        { "j-hui/fidget.nvim" },
        { "mbbill/undotree" },
        {
            "chentoast/marks.nvim",
            event = "VeryLazy",
        },
        {
            "lewis6991/gitsigns.nvim",
            opts = {
                signs = {
                    add = { text = "+" },
                    change = { text = "~" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                },
            },
        },
        {
            "lukas-reineke/virt-column.nvim",
            config = true,
        },
        {
            "brenoprata10/nvim-highlight-colors",
            config = true,
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
            "zeioth/garbage-day.nvim",
            dependencies = "neovim/nvim-lspconfig",
            event = "VeryLazy",
            config = true,
        },
        -- {
        --     "RishabhRD/nvim-lsputils",
        --     dependencies = {
        --         "RishabhRD/popfix"
        --     },
        --     opts = {
        --         lsp_utils_codeaction_opts = {
        --             mode = "editor",
        --         }
        --     },
        --     config = function()
        --         if vim.fn.has('nvim-0.5.1') == 1 then
        --             vim.lsp.handlers['textDocument/codeAction'] = require 'lsputil.codeAction'.code_action_handler
        --             vim.lsp.handlers['textDocument/references'] = require 'lsputil.locations'.references_handler
        --             vim.lsp.handlers['textDocument/definition'] = require 'lsputil.locations'.definition_handler
        --             vim.lsp.handlers['textDocument/declaration'] = require 'lsputil.locations'.declaration_handler
        --             vim.lsp.handlers['textDocument/typeDefinition'] = require 'lsputil.locations'.typeDefinition_handler
        --             vim.lsp.handlers['textDocument/implementation'] = require 'lsputil.locations'.implementation_handler
        --             vim.lsp.handlers['textDocument/documentSymbol'] = require 'lsputil.symbols'.document_handler
        --             vim.lsp.handlers['workspace/symbol'] = require 'lsputil.symbols'.workspace_handler
        --         else
        --             local bufnr = vim.api.nvim_buf_get_number(0)
        --
        --             vim.lsp.handlers['textDocument/codeAction'] = function(_, _, actions)
        --                 require('lsputil.codeAction').code_action_handler(nil, actions, nil, nil, nil)
        --             end
        --
        --             vim.lsp.handlers['textDocument/references'] = function(_, _, result)
        --                 require('lsputil.locations').references_handler(nil, result, { bufnr = bufnr }, nil)
        --             end
        --
        --             vim.lsp.handlers['textDocument/definition'] = function(_, method, result)
        --                 require('lsputil.locations').definition_handler(nil, result, { bufnr = bufnr, method = method },
        --                     nil)
        --             end
        --
        --             vim.lsp.handlers['textDocument/declaration'] = function(_, method, result)
        --                 require('lsputil.locations').declaration_handler(nil, result, { bufnr = bufnr, method = method },
        --                     nil)
        --             end
        --
        --             vim.lsp.handlers['textDocument/typeDefinition'] = function(_, method, result)
        --                 require('lsputil.locations').typeDefinition_handler(nil, result,
        --                     { bufnr = bufnr, method = method }, nil)
        --             end
        --
        --             vim.lsp.handlers['textDocument/implementation'] = function(_, method, result)
        --                 require('lsputil.locations').implementation_handler(nil, result,
        --                     { bufnr = bufnr, method = method }, nil)
        --             end
        --
        --             vim.lsp.handlers['textDocument/documentSymbol'] = function(_, _, result, _, bufn)
        --                 require('lsputil.symbols').document_handler(nil, result, { bufnr = bufn }, nil)
        --             end
        --
        --             vim.lsp.handlers['textDocument/symbol'] = function(_, _, result, _, bufn)
        --                 require('lsputil.symbols').workspace_handler(nil, result, { bufnr = bufn }, nil)
        --             end
        --         end
        --     end
        -- },
        {
            'stevearc/quicker.nvim',
            event = "FileType qf",
            config = true,
        },
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
                    vim.cmd("colorscheme rose-pine-moon")
                end,
                set_light_mode = function()
                    vim.api.nvim_set_option_value("background", "light", {})
                    vim.cmd("colorscheme rose-pine-dawn")
                end,
            }
        },

        -- themes
        {
            "rose-pine/neovim",
            name = "rose-pine"
        },
        { "EdenEast/nightfox.nvim" },
        { "olimorris/onedarkpro.nvim" },
        {
            "catppuccin/nvim",
            name = "catppuccin",
            priority = 1000
        },
    },
})
