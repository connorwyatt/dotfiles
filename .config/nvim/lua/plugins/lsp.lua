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
    {
        "seblyng/roslyn.nvim",
        ft = "cs",
        config = true,
    },

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
                        auto_insert = false,
                    },
                },
            },
            sources = {
                default = {
                    "lazydev",
                    "lsp",
                    "path",
                    "buffer",
                    "snippets",
                },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
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
