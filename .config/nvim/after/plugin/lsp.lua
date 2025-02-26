local blink = require("blink.cmp")
local conform = require("conform")
local luasnipLoadersFromVscode = require("luasnip.loaders.from_vscode")
local mason = require("mason")
local masonConform = require("mason-conform")
local masonLspconfig = require("mason-lspconfig")
local telescopeBuiltin = require("telescope.builtin")
local whichKey = require("which-key")

vim.diagnostic.config({
    underline = true,
    update_in_insert = false,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.INFO] = "",
        },
    },
})

mason.setup()
masonLspconfig.setup()

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
        whichKey.add({
            { "<leader>lt", group = "Toggles", },
            {
                "<leader>lti",
                function()
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }),
                        { bufnr = 0 })
                end,
                desc = "Toggle inlay hints",
            },
        })

        vim.keymap.set("n", "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<cr>",
            { buffer = event.buf, desc = "Show hover" })
        vim.keymap.set("n", "<leader>ld", telescopeBuiltin.lsp_definitions,
            { buffer = event.buf, desc = "Go to definition" })
        vim.keymap.set("n", "<leader>lo", "<cmd>lua vim.lsp.buf.declaration()<cr>",
            { buffer = event.buf, desc = "Go to declaration" })
        vim.keymap.set("n", "<leader>li", telescopeBuiltin.lsp_implementations,
            { buffer = event.buf, desc = "Go to implementation" })
        vim.keymap.set("n", "<leader>ly", telescopeBuiltin.lsp_type_definitions,
            { buffer = event.buf, desc = "Go to type definition" })
        vim.keymap.set("n", "<leader>lu", telescopeBuiltin.lsp_references,
            { buffer = event.buf, desc = "Find references" })
        vim.keymap.set("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<cr>",
            { buffer = event.buf, desc = "Show signature help" })
        vim.keymap.set("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>",
            { buffer = event.buf, desc = "Rename symbol" })
        vim.keymap.set("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>",
            { buffer = event.buf, desc = "Code actions" })
    end,
})

whichKey.add({
    { "<leader>l", group = "LSP actions", },
})

vim.keymap.set({ "n", "x" }, "<leader>lf", function()
        conform.format({ async = true })
    end,
    { buffer = vim.api.nvim_get_current_buf(), desc = "Format" })

luasnipLoadersFromVscode.lazy_load()

local conform_formatters = {
    ["*"] = { "trim_whitespace" },
}

if vim.fn.executable("dotnet") == 1 then
    conform_formatters.cs = { "csharpier", "fallback", stop_after_first = true }
end

conform.setup({
    formatters_by_ft = conform_formatters,
    default_format_opts = {
        lsp_format = "fallback",
    },
    format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
        end
        return { timeout_ms = 500, lsp_format = "fallback" }
    end,
})

masonConform.setup()

masonLspconfig.setup_handlers({
    function(server_name)
        require("lspconfig")[server_name].setup({
            capabilities = blink.get_lsp_capabilities(),
        })
    end,
    ["omnisharp"] = function()
        require("lspconfig").omnisharp.setup {
            capabilities = blink.get_lsp_capabilities(),
            settings = {
                RoslynExtensionsOptions = {
                    EnableDecompilationSupport = true,
                    EnableAnalyzersSupport = nil,
                    EnableImportCompletion = true,
                    AnalyzeOpenDocumentsOnly = true,
                },
            },
        }
    end
})
