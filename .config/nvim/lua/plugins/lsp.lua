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
        version = "v0.13.*",
        opts = {
            keymap = {
                preset = "enter",
                ["<Tab>"] = {},
                ["<S-Tab>"] = {},
                ["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
                ["<C-k>"] = {},
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
            snippets = {
                preset = "luasnip",
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
                    ["<Tab>"] = { "show_and_insert", "select_next", },
                    ["<S-Tab>"] = { "show_and_insert", "select_prev", },
                },
                completion = {
                    menu = {
                        auto_show = false,
                    },
                    list = {
                        selection = {
                            preselect = true,
                            auto_insert = true,
                        },
                    },
                },
            },
            signature = {
                enabled = true,
                trigger = {
                    show_on_keyword = true,
                    show_on_trigger_character = true,
                    show_on_insert = true,
                },
            },
        },
    },

    -- Snippets
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        opts = {
            update_events = { "TextChanged", "TextChangedI", },
        },
    },

    -- Debugging
    { "mfussenegger/nvim-dap", },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        opts = {},
    },
    { "jay-babu/mason-nvim-dap.nvim", },

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
