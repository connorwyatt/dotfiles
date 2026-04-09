return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        init = function()
            vim.highlight.priorities.semantic_tokens = 95 -- Or any number lower than 100, treesitter's priority level
        end,
        opts = {
            auto_install = true,
            ensure_installed = { "comment" },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            max_lines = 3,
        },
    },
}
