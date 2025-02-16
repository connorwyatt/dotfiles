local whichKey = require("which-key")

whichKey.add({
    { "<leader>tu", vim.cmd.UndotreeToggle, desc = "Toggle Undotree" },
})
