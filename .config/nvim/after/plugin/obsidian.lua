local whichKey = require("which-key")

if not _G.cw.is_obsidian_vault then
    return
end

vim.opt.conceallevel = 2

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
        "<leader>od",
        function()
            vim.cmd(":Obsidian dailies")
        end,
        desc = "Dailies",
    },
    {
        "<leader>ot",
        function()
            vim.cmd(":Obsidian today")
        end,
        desc = "Today Daily",
    },
    {
        "<leader>ob",
        function()
            vim.cmd(":Obsidian backlinks")
        end,
        desc = "Backlinks",
    },
})
