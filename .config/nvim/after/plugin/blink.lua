local blink = require("blink-cmp")

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI", "TextChanged", "TextChangedI" }, {
    callback = function()
        if blink.is_signature_visible() then
            return
        end

        vim.schedule(function()
            if vim.fn.mode() ~= "n" then
                blink.show_signature()
            end
        end)
    end,
})
