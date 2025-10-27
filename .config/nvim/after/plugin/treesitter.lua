local treesitter_configs = require("nvim-treesitter.configs")

vim.highlight.priorities.semantic_tokens = 95 -- Or any number lower than 100, treesitter's priority level

treesitter_configs.setup({
    auto_install = true,
    ensure_installed = { "comment" },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },
})
