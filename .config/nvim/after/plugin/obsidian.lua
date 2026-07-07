local whichKey = require("which-key")

local function register_obsidian_keybinds()
    whichKey.add({
        { "<leader>o", group = "Obsidian" },
        {
            "<leader>os",
            function()
                vim.cmd(":Obsidian quick_switch")
            end,
            desc = "Quick Switch",
        },
        {
            "<leader>ot",
            function()
                vim.cmd(":Obsidian tags")
            end,
            desc = "Tags",
        },
        {
            "<leader>ob",
            function()
                vim.cmd(":Obsidian backlinks")
            end,
            desc = "Backlinks",
        },
    })
end

vim.api.nvim_create_autocmd("User", {
    pattern = "LazyLoad",
    callback = function(event)
        if event.data == "obsidian.nvim" then
            register_obsidian_keybinds()
        end
    end,
})
