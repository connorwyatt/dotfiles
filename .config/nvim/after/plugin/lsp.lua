local blink = require("blink-cmp")
local dap = require("dap")
local dapui = require("dapui")
local lspconfig = require("lspconfig")
local luasnip = require("luasnip")
local luasnip_types = require("luasnip.util.types")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local mason_nvim_dap = require("mason-nvim-dap")
local which_key = require("which-key")

-- Diagnostics

vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = { current_line = true },
    underline = true,
    update_in_insert = false,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰀨",
            [vim.diagnostic.severity.WARN] = "󰀦",
            [vim.diagnostic.severity.HINT] = "󰋼",
            [vim.diagnostic.severity.INFO] = "󰋗",
        },
    },
})

-- Mason

mason.setup()

-- LSPs

mason_lspconfig.setup()

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

mason_lspconfig.setup_handlers({
    rust_analyzer = function(server_name)
        lspconfig[server_name].setup({
            completion = {
                capable = {
                    snippets = "add_parenthesis",
                },
            },
        })
    end,
    lua_ls = function(server_name)
        lspconfig[server_name].setup({
            settings = {
                Lua = {
                    completion = {
                        callSnippet = "Disable",
                        keywordSnippet = "Disable",
                    },
                },
            },
        })
    end,
    function(server_name)
        lspconfig[server_name].setup({
            capabilities = lsp_capabilities,
        })
    end,
})

-- Completion

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI", "TextChanged", "TextChangedI" }, {
    callback = function()
        if blink.is_signature_visible() then
            return
        end

        vim.schedule(function()
            if vim.fn.mode() ~= "n" then
                blink.show_signature()
            end
        end)
    end,
})

-- Debugging

which_key.add({
    { "<leader>b", group = "Debugging" },
    { "<leader>bb", "<cmd>lua require('dap').toggle_breakpoint()<cr>", desc = "Toggle breakpoint" },
    { "<leader>bl", "<cmd>lua require('dap').list_breakpoints()<cr>", desc = "List breakpoints" },
    { "<leader>bx", "<cmd>lua require('dap').clear_breakpoints()<cr>", desc = "Clear breakpoints" },
    { "<leader>bc", "<cmd>lua require('dap').continue()<cr>", desc = "Continue" },
    { "<leader>br", "<cmd>lua require('dap').restart()<cr>", desc = "Restart" },
    { "<leader>bq", "<cmd>lua require('dap').terminate()<cr>", desc = "Terminate" },
    { "<leader>bl", "<cmd>lua require('dap').step_over()<cr>", desc = "Step over" },
    { "<leader>bj", "<cmd>lua require('dap').step_into()<cr>", desc = "Step into" },
    { "<leader>bk", "<cmd>lua require('dap').step_out()<cr>", desc = "Step out" },
    { "<leader>bu", "<cmd>lua require('dapui').toggle()<cr>", desc = "Toggle UI" },
})

vim.fn.sign_define(
    "DapBreakpoint",
    { text = "", texthl = "DapBreakpointSign", linehl = "DapBreakpointLine", numhl = "DapBreakpointLineNumber" }
)
vim.fn.sign_define("DapBreakpointCondition", {
    text = "",
    texthl = "DapBreakpointConditionSign",
    linehl = "DapBreakpointConditionLine",
    numhl = "DapBreakpointConditionLineNumber",
})
vim.fn.sign_define(
    "DapLogPoint",
    { text = "", texthl = "DapLogPointSign", linehl = "DapLogPointLine", numhl = "DapLogPointLineNumber" }
)
vim.fn.sign_define(
    "DapStopped",
    { text = "", texthl = "DapStoppedSign", linehl = "DapStoppedLine", numhl = "DapStoppedLineNumber" }
)
vim.fn.sign_define("DapBreakpointRejected", {
    text = "",
    texthl = "DapBreakpointRejectedSign",
    linehl = "DapBreakpointRejectedLine",
    numhl = "DapBreakpointRejectedLineNumber",
})

mason_nvim_dap.setup({
    handlers = {
        coreclr = function(config)
            config.adapters = {
                type = "executable",
                command = vim.fn.exepath("netcoredbg"),
                args = { "--interpreter=vscode" },
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
    update_events = { "TextChanged", "TextChangedI" },
    region_check_events = { "CursorMoved", "CursorMovedI" },
    store_selection_keys = "<Tab>",
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
                virt_text = { { "", "LuasnipChoiceNodeVisitedVirtualText" } },
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
                virt_text = { { "", "LuasnipInsertNodeVisitedVirtualText" } },
            },
        },
    },
})

local load_luasnip_snippets = function()
    local loader = require("luasnip.loaders.from_lua")
    loader.clean()
    loader.lazy_load({
        paths = {
            vim.fn.stdpath("config") .. "/lua/snippets",
        },
    })
end

vim.api.nvim_create_user_command("ReloadSnippets", load_luasnip_snippets, {
    nargs = 0,
    desc = "Reload snippets",
})

load_luasnip_snippets()

local function set_choice_callback(_, indx)
    if not indx then
        return
    end
    vim.api.nvim_feedkeys("i", "x", false)
    luasnip.set_choice(indx)
    luasnip.jump(1)
end

local function select_choice()
    vim.ui.select(luasnip.get_current_choices(), { kind = "luasnip" }, set_choice_callback)
end

vim.keymap.set({ "i", "s" }, "<C-k>", function()
    if luasnip.choice_active() then
        select_choice()
    elseif luasnip.expandable() then
        luasnip.expand({})
    end
end)
vim.keymap.set({ "i", "s" }, "<C-l>", function()
    if luasnip.in_snippet() then
        luasnip.jump(1)
    end
end)
vim.keymap.set({ "i", "s" }, "<C-j>", function()
    if luasnip.in_snippet() then
        luasnip.jump(-1)
    end
end)
