local cmp = require("cmp")
local cmpNvimLsp = require("cmp_nvim_lsp")
local conform = require("conform")
local lspkind = require("lspkind")
local luasnip = require("luasnip")
local mason = require("mason")
local masonLspconfig = require("mason-lspconfig")
local whichKey = require("which-key")

mason.setup()
masonLspconfig.setup()

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
        whichKey.add({
            { "<leader>l",  group = "LSP actions", },
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
        vim.keymap.set("n", "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<cr>",
            { buffer = event.buf, desc = "Go to definition" })
        vim.keymap.set("n", "<leader>lo", "<cmd>lua vim.lsp.buf.declaration()<cr>",
            { buffer = event.buf, desc = "Go to declaration" })
        vim.keymap.set("n", "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<cr>",
            { buffer = event.buf, desc = "Go to implementation" })
        vim.keymap.set("n", "<leader>ly", "<cmd>lua vim.lsp.buf.type_definition()<cr>",
            { buffer = event.buf, desc = "Go to type definition" })
        vim.keymap.set("n", "<leader>lu", "<cmd>lua vim.lsp.buf.references()<cr>",
            { buffer = event.buf, desc = "Find references" })
        vim.keymap.set("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<cr>",
            { buffer = event.buf, desc = "Show signature help" })
        vim.keymap.set("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>",
            { buffer = event.buf, desc = "Rename symbol" })
        vim.keymap.set({ "n", "x" }, "<leader>lf", function()
                conform.format({ async = true })
            end,
            { buffer = event.buf, desc = "Format" })
        vim.keymap.set("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>",
            { buffer = event.buf, desc = "Code actions" })
    end,
})


cmp.setup({
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol_text",
        }),
    },
    sources = {
        { name = "nvim_lsp", },
        { name = "nvim_lsp_signature_help", },
        { name = "path", },
        { name = "luasnip", },
        { name = "buffer", },
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                if luasnip.expandable() then
                    luasnip.expand()
                else
                    cmp.confirm({
                        select = true,
                    })
                end
            else
                fallback()
            end
        end),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.locally_jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    preselect = "item",
})

cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "nvim_lsp_document_symbol", },
        { name = "buffer", },
    }
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path", },
        { name = "cmdline", },
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
})

conform.setup({
    formatters_by_ft = {
        cs = { "csharpier", "fallback", stop_after_first = true },
        ["*"] = { "trim_whitespace" },
    },
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

local capabilities = cmpNvimLsp.default_capabilities()

masonLspconfig.setup_handlers({
    function(server_name)
        require("lspconfig")[server_name].setup({
            capabilities = capabilities,
        })
    end,
    ["omnisharp"] = function()
        require("lspconfig").omnisharp.setup {
            capabilities = capabilities,
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
