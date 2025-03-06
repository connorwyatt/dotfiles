local dap = require("dap")
local dapui = require("dapui")
local whichKey = require("which-key")

whichKey.add({
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

dap.adapters.cs = {
    type = "executable",
    command = vim.fn.exepath("netcoredbg"),
    args = { "--interpreter=vscode" }
}

dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
