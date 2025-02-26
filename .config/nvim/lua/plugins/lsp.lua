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
                ["<Esc>"] = { "hide", "fallback", },
                ["<C-s>"] = { function(cmp) cmp.show({ providers = { "snippets" } }) end },
                ["<Tab>"] = { "select_and_accept", "snippet_forward", "fallback" },
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
                        preselect = false,
                        auto_insert = true,
                    },
                },
                menu = {
                    draw = {
                        treesitter = { "lsp" },
                    },
                },
                ghost_text = {
                    enabled = true,
                    show_with_selection = true,
                    show_without_selection = true,
                },
            },
            signature = {
                enabled = true,
            },
            sources = {
                default = {
                    "lsp",
                    "path",
                    "buffer",
                },
            },
        },
        opts_extend = { "sources.default" }
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
