local blink = require("blink-cmp")
local navic = require("nvim-navic")
local which_key = require("which-key")

vim.diagnostic.config({
    --- Disabled as we have tiny-inline-diagnostic
    virtual_text = false,
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

local function lsp_on_attach(client, bufnr)
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
    }, { buffer = bufnr })
end

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

vim.lsp.config("*", {
    capabilities = lsp_capabilities,
    on_attach = lsp_on_attach,
})
