local configs = require("nvim-treesitter.configs")

configs.setup({
    auto_install = true,
    ensure_installed = { "comment", },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },
})
