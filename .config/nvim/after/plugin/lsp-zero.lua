require("mason").setup({
    automatic_installation = true,
})
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers {
    function(server_name)
        require("lspconfig")[server_name].setup {}
    end,
}

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
        vim.keymap.set("n", "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<cr>",
            { buffer = event.buf, desc = "Show hover" })
        vim.keymap.set("n", "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<cr>",
            { buffer = event.buf, desc = "Go to definition" })
        vim.keymap.set("n", "<leader>lo", "<cmd>lua vim.lsp.buf.declaration()<cr>",
            { buffer = event.buf, desc = "Go to declaration" })
        vim.keymap.set("n", "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<cr>",
            { buffer = event.buf, desc = "Go to implementation" })
        vim.keymap.set("n", "<leader>lt", "<cmd>lua vim.lsp.buf.type_definition()<cr>",
            { buffer = event.buf, desc = "Go to type definition" })
        vim.keymap.set("n", "<leader>lu", "<cmd>lua vim.lsp.buf.references()<cr>",
            { buffer = event.buf, desc = "Find references" })
        vim.keymap.set("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<cr>",
            { buffer = event.buf, desc = "Show signature help" })
        vim.keymap.set("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>",
            { buffer = event.buf, desc = "Rename symbol" })
        vim.keymap.set({ "n", "x" }, "<leader>lf", function()
                require("conform").format({ async = true })
            end,
            { buffer = event.buf, desc = "Format" })
        vim.keymap.set("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>",
            { buffer = event.buf, desc = "Show code options" })
    end,
})

require("conform").setup({
    formatters_by_ft = {
        cs = { "csharpier", "fallback", stop_after_first = true },
    },
    default_format_opts = {
        lsp_format = "fallback",
    },
})

local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local lspkind = require("lspkind")
cmp.event:on(
    "confirm_done",
    cmp_autopairs.on_confirm_done()
)
cmp.setup({
    view = {
        entries = { name = 'custom', selection_order = 'near_cursor' }
    },
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol_text",
        }),
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "path" },
        { name = "buffer" },
    },
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true })
    }),
    preselect = "item",
})
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'nvim_lsp_document_symbol' }
    }, {
        { name = 'buffer' }
    })
})
