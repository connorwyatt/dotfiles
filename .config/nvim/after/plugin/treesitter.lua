local configs = require("nvim-treesitter.configs")
local which_key = require("which-key")

vim.highlight.priorities.semantic_tokens = 95 -- Or any number lower than 100, treesitter's priority level

which_key.add({
    { "<leader>[", group = "swap node with previous", },
    { "<leader>]", group = "swap node with next", },
})

configs.setup({
    auto_install = true,
    ensure_installed = { "comment", },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ["af"] = { query = "@function.outer", desc = "outer part of function" },
                ["if"] = { query = "@function.inner", desc = "inner part of function", },
                ["ac"] = { query = "@class.outer", desc = "outer part of class", },
                ["ic"] = { query = "@class.inner", desc = "inner part of class", },
            },
            selection_modes = function()
                return "v"
            end,
        },
        swap = {
            enable = true,
            swap_next = {
                ["<leader>]m"] = { query = "@function.outer", desc = "function", },
                ["<leader>]p"] = { query = "@parameter.inner", desc = "parameter", },
            },
            swap_previous = {
                ["<leader>[m"] = { query = "@function.outer", desc = "function", },
                ["<leader>[p"] = { query = "@parameter.inner", desc = "parameter", },
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["]m"] = { query = "@function.outer", desc = "Next function start", },
            },
            goto_previous_start = {
                ["[m"] = { query = "@function.outer", desc = "Previous function start", },
            },
            goto_next_end = {
                ["]M"] = { query = "@function.outer", desc = "Next function end", },
            },
            goto_previous_end = {
                ["[M"] = { query = "@function.outer", desc = "Previous function end", },
            },
        },
    },
})
