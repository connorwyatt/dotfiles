return {
    { "neovim/nvim-lspconfig", },

    -- LSP Installation
    { "williamboman/mason.nvim", },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
    },

    -- Specific LSPs
    { "Hoffs/omnisharp-extended-lsp.nvim", },

    -- Autocompletion
    {
        "saghen/blink.cmp",
        version = "v0.12.4",
        opts = {
            keymap = {
                preset = "enter",
            },
            appearance = {
                nerd_font_variant = "normal"
            },
            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 0,
                    update_delay_ms = 0,
                },
                list = {
                    selection = {
                        preselect = true,
                        auto_insert = true,
                    },
                },
            },
            sources = {
                default = {
                    "lsp",
                    "path",
                    "buffer",
                    "snippets",
                },
            },
            cmdline = {
                keymap = {
                    ["<Tab>"] = { "show", "select_next", },
                    ["<S-Tab>"] = { "show", "select_prev", },
                },
                completion = {
                    menu = {
                        auto_show = false,
                    },
                },
            },
        },
    },

    -- Formatting
    {
        "stevearc/conform.nvim",
        config = true,
    },
    {
        "zapling/mason-conform.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "stevearc/conform.nvim",
        },
    },
}
