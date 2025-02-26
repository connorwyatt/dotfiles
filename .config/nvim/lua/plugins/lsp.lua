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
                ["<C-s>"] = { function(cmp) cmp.show({ providers = { "snippets" } }) end },
            },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = "mono"
            },
            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 0,
                },
                list = {
                    selection = {
                        preselect = false,
                        auto_insert = true,
                    },
                },
                ghost_text = {
                    enabled = false,
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
