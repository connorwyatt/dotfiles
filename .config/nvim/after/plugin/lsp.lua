local blink = require("blink.cmp")
local mason = require("mason")
local masonLspconfig = require("mason-lspconfig")
local whichKey = require("which-key")

vim.diagnostic.config({
    underline = true,
    update_in_insert = false,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.INFO] = "",
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

        vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>",
            { buffer = event.buf, desc = "Show hover" })
        vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>",
            { buffer = event.buf, desc = "Go to definition" })
        vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>",
            { buffer = event.buf, desc = "Go to declaration" })
        vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>",
            { buffer = event.buf, desc = "Go to implementation" })
        vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>",
            { buffer = event.buf, desc = "Go to type definition" })
        vim.keymap.set("n", "gr", "<cmd>lue vim.lsp.buf.references()<cr>",
            { buffer = event.buf, desc = "Find references" })
        vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>",
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
