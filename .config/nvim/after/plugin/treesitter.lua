require("nvim-treesitter.configs").setup {
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
require("nvim-ts-autotag").setup {}
require("nvim-treesitter.configs").setup {
    textobjects = {
        select = {
            enable = true,

            lookahead = true,

            keymaps = {
                ["af"] = { query = "@function.outer", desc = "Select outer part of a function" },
                ["if"] = { query = "@function.inner", desc = "Select inner part of a function" },
                ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
                ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
                ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
            },
            selection_modes = {
            },
            include_surrounding_whitespace = false,
        },
    },
}
