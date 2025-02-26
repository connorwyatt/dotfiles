local whichKey = require("which-key")

whichKey.add({
    { "<leader>f",  group = "Files", },
    { "<leader>ff", "<cmd>:Neotree reveal<cr>",                   desc = "File browser", },
    { "<leader>fb", "<cmd>:Neotree reveal source=buffers<cr>",    desc = "Open buffers", },
    { "<leader>fg", "<cmd>:Neotree reveal source=git_status<cr>", desc = "Git changed files", },
})
