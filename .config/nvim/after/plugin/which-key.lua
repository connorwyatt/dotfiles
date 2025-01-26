local whichKey = require("which-key")

whichKey.setup({
    preset = "modern",
    delay = 0,
    spec = {
        { "<leader>t", group = "Toggles", },
        {
            "<leader>tr",
            function()
                vim.o.relativenumber = not vim.o.relativenumber
            end,
            desc = "Toggle relative line numbers",
        },
        {
            "<leader>tw",
            function()
                vim.o.wrap = not vim.o.wrap
            end,
            desc = "Toggle wrap",
        },
    },
})
