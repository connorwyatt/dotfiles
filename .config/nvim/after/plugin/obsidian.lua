vim.api.nvim_create_autocmd("User", {
    pattern = "LazyLoad",
    callback = function(event)
        if event.data ~= "obsidian.nvim" then
            return
        end

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "markdown",
            callback = function()
                vim.opt_local.conceallevel = 2
            end,
        })
    end,
})
