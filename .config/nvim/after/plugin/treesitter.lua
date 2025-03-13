local configs = require("nvim-treesitter.configs")

vim.highlight.priorities.semantic_tokens = 95 -- Or any number lower than 100, treesitter's priority level

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
                ["<leader>[p"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>]p"] = "@parameter.inner",
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
