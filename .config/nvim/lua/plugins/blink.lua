return {

    {
        "saghen/blink.cmp",
        version = "1.*",
        dependencies = {
            "xzbdmw/colorful-menu.nvim",
        },
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                preset = "none",

                ["<C-space>"] = { "show", "hide", "fallback" },
                ["<C-d>"] = { "show_documentation", "hide_documentation", "fallback" },
                ["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
                ["<CR>"] = { "accept", "fallback" },

                ["<Tab>"] = { "select_and_accept", "fallback" },

                ["<Up>"] = { "select_prev", "fallback" },
                ["<Down>"] = { "select_next", "fallback" },

                ["<C-b>"] = { "scroll_documentation_up", "fallback" },
                ["<C-f>"] = { "scroll_documentation_down", "fallback" },
            },
            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 0,
                    update_delay_ms = 50,
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
                        columns = { { "label", "source_name", "kind_icon", gap = 1 } },
                        padding = { 1, 0 },
                        -- columns = { { "kind_icon", "label", "source_name", gap = 1 } },
                        -- padding = { 0, 1 },
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
                                    elseif ctx.kind == "Ripgrep" then
                                    else
                                        vim.print(ctx.kind)
                                        icon = require("lspkind").symbolic(ctx.kind, {
                                            mode = "symbol",
                                        }) or icon
                                    end

                                    return " " .. icon .. " "
                                end,
                            },
                            label = {
                                text = function(ctx)
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
            fuzzy = { implementation = "prefer_rust_with_warning" },
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
                per_filetype = {
                    gitcommit = {
                        "conventional_commits",
                        "path",
                        "snippets",
                        "buffer",
                    },
                    markdown = {
                        "path",
                        "snippets",
                        "buffer",
                        "ripgrep",
                        "markdown",
                    },
                },
                providers = {
                    lazydev = {
                        name = "",
                        enabled = function()
                            return vim.bo.filetype == "lua"
                        end,
                        async = true,
                        module = "lazydev.integrations.blink",
                        score_offset = 20,
                    },
                    lsp = {
                        name = "",
                        enabled = true,
                        async = true,
                        transform_items = function(_, items)
                            return vim.tbl_filter(function(item)
                                return item.kind ~= require("blink.cmp.types").CompletionItemKind.Keyword
                            end, items)
                        end,
                        should_show_items = true,
                        max_items = nil,
                        min_keyword_length = 0,
                        fallbacks = {},
                        score_offset = 20,
                    },
                    path = {
                        name = "",
                        enabled = true,
                        async = true,
                        transform_items = nil,
                        should_show_items = true,
                        max_items = nil,
                        min_keyword_length = 0,
                        fallbacks = {},
                        score_offset = 20,
                    },
                    snippets = {
                        name = "",
                        enabled = true,
                        async = true,
                        timeout_ms = 50,
                        transform_items = nil,
                        should_show_items = true,
                        max_items = nil,
                        min_keyword_length = 0,
                        fallbacks = {},
                        score_offset = 10,
                    },
                    buffer = {
                        name = "",
                        enabled = true,
                        async = true,
                        transform_items = nil,
                        should_show_items = true,
                        max_items = 10,
                        min_keyword_length = 0,
                        fallbacks = {},
                        score_offset = 5,
                    },
                    ripgrep = {
                        name = "",
                        module = "blink-ripgrep",
                        enabled = true,
                        async = true,
                        transform_items = nil,
                        should_show_items = true,
                        max_items = 10,
                        min_keyword_length = 3,
                        fallbacks = {},
                        score_offset = 0,
                        ---@module "blink-ripgrep"
                        ---@type blink-ripgrep.Options
                        opts = {
                            prefix_min_len = 3,
                            fallback_to_regex_highlighting = true,
                            backend = {
                                ripgrep = {
                                    context_size = 5,
                                    max_filesize = "1M",
                                    search_casing = "--smart-case",
                                    project_root_fallback = true,
                                },
                            },
                        },
                    },
                    conventional_commits = {
                        name = "",
                        module = "blink-cmp-conventional-commits",
                        enabled = false,
                        async = true,
                        score_offset = 25,
                    },
                },
            },
            cmdline = {
                keymap = {
                    preset = "none",

                    ["<C-space>"] = { "show" },
                    ["<C-e>"] = { "hide", "fallback" },
                    ["<CR>"] = { "accept", "fallback" },

                    ["<Up>"] = { "select_prev", "fallback" },
                    ["<Down>"] = { "select_next", "fallback" },

                    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
                    ["<C-f>"] = { "scroll_documentation_down", "fallback" },
                },
                completion = {
                    menu = {
                        auto_show = false,
                    },
                    list = {
                        selection = {
                            preselect = true,
                            auto_insert = false,
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
        "disrupted/blink-cmp-conventional-commits",
    },
    {
        "xzbdmw/colorful-menu.nvim",
        config = true,
    },
}
