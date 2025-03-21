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

    -- Utilities
    {
        "onsails/lspkind.nvim",
        config = true,
    },

    -- Autocompletion
    {
        "saghen/blink.cmp",
        version = "v0.13.*",
        dependencies = {
            "xzbdmw/colorful-menu.nvim",
        },
        opts = {
            keymap = {
                preset = "enter",
                ["<C-k>"] = {},
            },
            appearance = {
                nerd_font_variant = "normal",
            },
            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 0,
                    update_delay_ms = 0,
                },
                ghost_text = {
                    enabled = false,
                },
                list = {
                    selection = {
                        preselect = true,
                        auto_insert = false,
                    },
                },
                menu = {
                    draw = {
                        columns = { { "kind_icon", "label", "source_name", gap = 1, }, },
                        padding = { 0, 1, },
                        components = {
                            kind_icon = {
                                ellipsis = false,
                                text = function(ctx)
                                    local icon = ctx.kind_icon
                                    if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                        local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                                        if dev_icon then
                                            icon = dev_icon
                                        end
                                    else
                                        icon = require("lspkind").symbolic(ctx.kind, {
                                            mode = "symbol",
                                        })
                                    end
                                    return " " .. icon .. " "
                                end,
                            },
                            label = {
                                text      = function(ctx)
                                    return require("colorful-menu").blink_components_text(ctx)
                                end,
                                highlight = function(ctx)
                                    return require("colorful-menu").blink_components_highlight(ctx)
                                end,
                            },
                        },
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
                    "snippets",
                    "buffer",
                    "ripgrep",
                },
                providers = {
                    lazydev = {
                        name = "",
                        module = "lazydev.integrations.blink",
                        score_offset = 50,
                    },
                    lsp = {
                        name = "",
                        enabled = true,
                        async = false,
                        timeout_ms = 50,
                        transform_items = nil,
                        should_show_items = true,
                        max_items = nil,
                        min_keyword_length = 0,
                        fallbacks = {},
                        score_offset = 40,
                    },
                    path = {
                        name = "",
                        enabled = true,
                        async = false,
                        timeout_ms = 50,
                        transform_items = nil,
                        should_show_items = true,
                        max_items = nil,
                        min_keyword_length = 0,
                        fallbacks = {},
                        score_offset = 30,
                    },
                    snippets = {
                        name = "",
                        enabled = true,
                        async = false,
                        timeout_ms = 50,
                        transform_items = nil,
                        should_show_items = true,
                        max_items = nil,
                        min_keyword_length = 0,
                        fallbacks = {},
                        score_offset = 20,
                    },
                    buffer = {
                        name = " ",
                        enabled = true,
                        async = false,
                        timeout_ms = 50,
                        transform_items = nil,
                        should_show_items = true,
                        max_items = 5,
                        min_keyword_length = 3,
                        fallbacks = { "ripgrep", },
                        score_offset = 10,
                    },
                    ripgrep = {
                        module = "blink-ripgrep",
                        name = " ",
                        enabled = true,
                        async = false,
                        timeout_ms = 50,
                        transform_items = nil,
                        should_show_items = true,
                        max_items = 5,
                        min_keyword_length = 3,
                        fallbacks = {},
                        score_offset = 0,
                        -- the options below are optional, some default values are shown
                        ---@module "blink-ripgrep"
                        ---@type blink-ripgrep.Options
                        opts = {
                            prefix_min_len = 3,
                            context_size = 5,
                            max_filesize = "1M",
                            project_root_marker = {},
                            project_root_fallback = true,
                            search_casing = "--smart-case",
                            fallback_to_regex_highlighting = true,
                            ignore_paths = {},
                            additional_paths = {},
                        },
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
    {
        "mikavilpas/blink-ripgrep.nvim",
    },
    {
        "xzbdmw/colorful-menu.nvim",
        config = true,
    },

    -- Snippets
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        event = "InsertEnter",
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
