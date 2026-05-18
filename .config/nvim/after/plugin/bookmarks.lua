local whichKey = require("which-key")

whichKey.add({
    { "<leader>b", group = "Bookmarks" },
    {
        "<leader>ba",
        ":BookmarkAdd<CR>",
        desc = "Add",
    },
    {
        "<leader>bd",
        ":BookmarkRemove<CR>",
        desc = "Delete",
    },
    {
        "<leader>bs",
        function()
            local bm = require("bookmarks.storage").get_bookmarks()

            Snacks.picker.pick({
                title = "Bookmarks",
                items = vim.tbl_map(function(b)
                    return {
                        file = b.filename,
                        pos = { b.line, 0 },
                        text = b.content .. " (" .. b.filename .. ")",
                    }
                end, bm),
                format = "file",
                confirm = "jump",
            })
        end,
        desc = "Search",
    },
})
