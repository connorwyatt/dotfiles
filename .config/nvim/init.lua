-------------------------
-- BASIC CONFIGURATION --
-------------------------
-- Disable netrw.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Make space the leader key and backslash the local leader key.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Line numbers.
vim.opt.number = true
-- Relative line numbers.
vim.opt.relativenumber = true

-- Indentation.
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Column line.
vim.opt.colorcolumn = "80"

-- Don't wrap by default.
vim.opt.wrap = false
-- Wrap at word boundary.
vim.opt.linebreak = true

-- Highlight line that cursor is on.
vim.opt.cursorline = true

-- Enable mouse mode, useful for resizing splits.
vim.opt.mouse = "a"

-- Cursor
vim.o.guicursor =
    "n-v-c:block,i-ci-ve-sm:ver25,r-cr:hor20,o:hor50,a:Cursor/lCursor,i-ci-ve-sm-r-cr-o:blinkwait400-blinkoff400-blinkon400"

-- Disable mode display, it's already in heirline.
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

-- Stop nvim waiting for more keys when typing a keybind.
vim.opt.ttimeoutlen = 0

-- Decrease update time.
vim.opt.updatetime = 16

-- Preview replacements inline.
vim.opt.inccommand = "split"

-- Show at least 5 lines either side of cursor.
vim.opt.scrolloff = 5

vim.opt.termguicolors = true

-- Invisible characters.
vim.opt.list = false
vim.opt.listchars = { tab = "» ", space = "·", trail = "·", nbsp = "␣" }
vim.opt.fillchars:append({ diff = "╱" })

-- nvim-ufo suggested folding configuration.
vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

----------------
-- KEYMAPPING --
----------------

local noop = function() end

-- Disable arrow keys in normal mode.
vim.keymap.set("n", "<left>", noop)
vim.keymap.set("n", "<right>", noop)
vim.keymap.set("n", "<up>", noop)
vim.keymap.set("n", "<down>", noop)

-- Clear search highlights on escape.
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Use escape to exit terminal mode.
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

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
            { out, "WarningMsg" },
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
        notify = false,
        check_pinned = true,
    },
    change_detection = {
        notify = false,
    },
    dev = {
        path = "~/Code",
        fallback = true,
    },
    ui = {
        size = {
            width = 1,
            height = 1,
        },
    },
    spec = {
        { import = "plugins" },
    },
})
