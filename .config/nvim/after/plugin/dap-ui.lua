local dap, dapui = require("dap"), require("dapui")

dapui.setup()

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end

vim.keymap.set("n", "<leader>dpo", "<cmd>lua require'dapui'.open()<cr>")
vim.keymap.set("n", "<leader>dpc", "<cmd>lua require'dapui'.close()<cr>")
