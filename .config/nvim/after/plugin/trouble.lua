local whichKey = require("which-key")

whichKey.add({
    { "<leader>db", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics", },
    { "<leader>dw", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Workspace diagnostics", },
    { "<leader>lo", "<cmd>Trouble symbols toggle focus=false<cr>",      desc = "Symbols sidebar", },
    { "<leader>ll", "<cmd>Trouble lsp open focus=true<cr>",             desc = "LSP definitions & references", },
})
