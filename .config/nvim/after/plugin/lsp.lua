local blink = require("blink-cmp")
local which_key = require("which-key")

vim.diagnostic.config({
    virtual_text = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰀨",
            [vim.diagnostic.severity.WARN] = "󰀦",
            [vim.diagnostic.severity.HINT] = "󰋼",
            [vim.diagnostic.severity.INFO] = "󰋗",
        },
    },
})

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function()
        which_key.add({
            {
                "gd",
                function()
                    Snacks.picker.lsp_definitions()
                end,
                desc = "Go to definition",
            },
            {
                "gD",
                function()
                    Snacks.picker.lsp_declarations()
                end,
                desc = "Go to declaration",
            },
            { "gra", desc = "Code actions" },
            { "grn", desc = "Rename" },
            {
                "grr",
                function()
                    Snacks.picker.lsp_references()
                end,
                nowait = true,
                desc = "References",
            },
            {
                "gri",
                function()
                    Snacks.picker.lsp_implementations()
                end,
                desc = "Go to implementation",
            },
            {
                "gry",
                function()
                    Snacks.picker.lsp_type_definitions()
                end,
                desc = "Go to type definition",
            },
            { "gO", desc = "Document symbols" },
        })
    end,
})

local lsp_capabilities = blink.get_lsp_capabilities({
    textDocument = {
        completion = {
            completionItem = {
                snippetSupport = false,
            },
        },
        foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        },
    },
})

--- Specific LSP Configuration

vim.lsp.config("rust_analyzer", {
    completion = {
        capable = {
            snippets = "add_parenthesis",
        },
    },
})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            completion = {
                callSnippet = "Disable",
                keywordSnippet = "Disable",
            },
        },
    },
})
