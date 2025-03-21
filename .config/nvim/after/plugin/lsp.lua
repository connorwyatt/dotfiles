local blink = require("blink.cmp")
local dap = require("dap")
local dapui = require("dapui")
local luasnip = require("luasnip")
local luasnip_types = require("luasnip.util.types")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local mason_nvim_dap = require("mason-nvim-dap")
local which_key = require("which-key")

-- Diagnostics

vim.diagnostic.config({
    virtual_text = false,
    underline = true,
    update_in_insert = false,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰀨 ",
            [vim.diagnostic.severity.WARN] = "󰀦 ",
            [vim.diagnostic.severity.HINT] = "󰋼 ",
            [vim.diagnostic.severity.INFO] = "󰋗 ",
        },
    },
})

vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        if vim.lsp.buf_is_attached() and vim.api.nvim_get_mode().mode == "n" then
            vim.diagnostic.open_float(0, {
                scope = "cursor",
                focusable = false,
                close_events = {
                    "CursorMoved",
                    "CursorMovedI",
                    "BufHidden",
                    "InsertCharPre",
                    "WinLeave",
                },
            })
        end
    end,
})

-- Mason

mason.setup()

-- LSPs

mason_lspconfig.setup()

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
        which_key.add({
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
        vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>",
            { buffer = event.buf, desc = "Find references" })
        vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>",
            { buffer = event.buf, desc = "Show signature help" })
        vim.keymap.set("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>",
            { buffer = event.buf, desc = "Rename symbol" })
        vim.keymap.set("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>",
            { buffer = event.buf, desc = "Code actions" })
    end,
})

which_key.add({
    { "<leader>l", group = "LSP actions", },
})

local lsp_capabilities = blink.get_lsp_capabilities({
    textDocument = {
        completion = {
            completionItem = {
                snippetSupport = false,
            },
        }
    },
})

mason_lspconfig.setup_handlers({
    rust_analyzer = function(server_name)
        require("lspconfig")[server_name].setup({
            completion = {
                capable = {
                    snippets = "add_parenthesis"
                }
            }
        })
    end,
    lua_ls = function(server_name)
        require("lspconfig")[server_name].setup({
            settings = {
                Lua = {
                    completion = {
                        callSnippet = "Disable",
                        keywordSnippet = "Disable",
                    }
                }
            }
        })
    end,
    function(server_name)
        require("lspconfig")[server_name].setup({
            capabilities = lsp_capabilities,
        })
    end,
})

-- Debugging

which_key.add({
    { "<leader>b",  group = "Debugging", },
    { "<leader>bb", "<cmd>lua require('dap').toggle_breakpoint()<cr>", desc = "Toggle breakpoint", },
    { "<leader>bl", "<cmd>lua require('dap').list_breakpoints()<cr>",  desc = "List breakpoints", },
    { "<leader>bx", "<cmd>lua require('dap').clear_breakpoints()<cr>", desc = "Clear breakpoints", },
    { "<leader>bc", "<cmd>lua require('dap').continue()<cr>",          desc = "Continue", },
    { "<leader>br", "<cmd>lua require('dap').restart()<cr>",           desc = "Restart", },
    { "<leader>bq", "<cmd>lua require('dap').terminate()<cr>",         desc = "Terminate", },
    { "<leader>bl", "<cmd>lua require('dap').step_over()<cr>",         desc = "Step over", },
    { "<leader>bj", "<cmd>lua require('dap').step_into()<cr>",         desc = "Step into", },
    { "<leader>bk", "<cmd>lua require('dap').step_out()<cr>",          desc = "Step out", },
    { "<leader>bu", "<cmd>lua require('dapui').toggle()<cr>",          desc = "Toggle UI", },
})

vim.fn.sign_define("DapBreakpoint",
    { text = "", texthl = "DapBreakpointSign", linehl = "DapBreakpointLine", numhl = "DapBreakpointLineNumber", })
vim.fn.sign_define("DapBreakpointCondition",
    {
        text = "",
        texthl = "DapBreakpointConditionSign",
        linehl = "DapBreakpointConditionLine",
        numhl =
        "DapBreakpointConditionLineNumber",
    })
vim.fn.sign_define("DapLogPoint",
    { text = "", texthl = "DapLogPointSign", linehl = "DapLogPointLine", numhl = "DapLogPointLineNumber", })
vim.fn.sign_define("DapStopped",
    { text = "", texthl = "DapStoppedSign", linehl = "DapStoppedLine", numhl = "DapStoppedLineNumber", })
vim.fn.sign_define("DapBreakpointRejected",
    {
        text = "",
        texthl = "DapBreakpointRejectedSign",
        linehl = "DapBreakpointRejectedLine",
        numhl =
        "DapBreakpointRejectedLineNumber",
    })

mason_nvim_dap.setup({
    handlers = {
        coreclr = function(config)
            config.adapters = {
                type = "executable",
                command = vim.fn.exepath("netcoredbg"),
                args = { "--interpreter=vscode" }
            }

            require("mason-nvim-dap").default_setup(config)
        end,
    },
})

dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end

-- Snippets
luasnip.setup({
    update_events = { "TextChanged", "TextChangedI", },
    ext_opts = {
        [luasnip_types.choiceNode] = {
            active = {
                hl_group = "LuasnipChoiceNodeActive",
                virt_text = { { "", "LuasnipChoiceNodeActiveVirtualText" } },
            },
            unvisited = {
                hl_group = "LuasnipChoiceNodeUnvisited",
                virt_text = { { "", "LuasnipChoiceNodeUnvisitedVirtualText" } },
            },
            visited = {
                hl_group = "LuasnipChoiceNodeVisited",
                virt_text = { { "", "LuasnipChoiceNodeVisitedVirtualText" } },
            },
        },
        [luasnip_types.insertNode] = {
            active = {
                hl_group = "LuasnipInsertNodeActive",
                virt_text = { { "", "LuasnipInsertNodeActiveVirtualText" } },
            },
            unvisited = {
                hl_group = "LuasnipInsertNodeUnvisited",
                virt_text = { { "", "LuasnipInsertNodeUnvisitedVirtualText" } },
            },
            visited = {
                hl_group = "LuasnipInsertNodeVisited",
                virt_text = { { "", "LuasnipInsertNodeVisitedVirtualText" } },
            },
        }
    },
})

local load_luasnip_snippets = function()
    local loader = require("luasnip.loaders.from_lua")
    loader.clean()
    loader.lazy_load({
        paths = {
            vim.fn.stdpath("config") .. "/snippets",
        },
    })
end

vim.api.nvim_create_user_command("ReloadSnippets", load_luasnip_snippets, {
    nargs = 0,
    desc = "Reload snippets",
})

load_luasnip_snippets()

vim.keymap.set("n", "<C-s>",
    function()
        luasnip.unlink_current()
    end,
    { silent = true })
vim.keymap.set({ "i", "s" }, "<C-c>",
    function()
        if luasnip.choice_active() then
            luasnip.change_choice(1)
        end
    end,
    { silent = true })
