local conform = require("conform")
local masonConform = require("mason-conform")
local whichKey = require("which-key")

whichKey.add({
    { "<leader>r", group = "Reformatting", },
    {
        "<leader>rf",
        "<cmd>Reformat<cr>",
        mode = { "n", "v" },
        desc = "Reformat",
    },
    { "<leader>ft", group = "Toggles", },
    {
        "<leader>rtg",
        "<cmd>ReformatToggle<cr>",
        desc = "Toggle global reformat on save",
    },
    {
        "<leader>rtb",
        "<cmd>ReformatToggle!<cr>",
        desc = "Toggle buffer reformat on save",
    },
})

local conform_formatters = {
    ["*"] = { "trim_whitespace" },
}

if vim.fn.executable("dotnet") == 1 then
    conform_formatters.cs = { "csharpier", "fallback", stop_after_first = true }
end

conform.setup({
    formatters_by_ft = conform_formatters,
    default_format_opts = {
        lsp_format = "fallback",
    },
    format_on_save = function(bufnr)
        if not vim.g.enable_autoformat and not vim.b[bufnr].enable_autoformat then
            return
        end
        return { timeout_ms = 2000, }
    end,
})

masonConform.setup()

vim.api.nvim_create_user_command("Reformat", function(args)
    local range = nil
    if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
        }
    end
    conform.format({ async = true, range = range }, function(err)
        if not err then
            local mode = vim.api.nvim_get_mode().mode
            if vim.startswith(string.lower(mode), "v") then
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
            end
        end
    end)
end, { range = true })

vim.api.nvim_create_user_command("ReformatToggle", function(args)
    if args.bang then
        -- ReformatToggle! will toggle formatting just for this buffer
        vim.b.enable_autoformat = not vim.b.enable_autoformat
    else
        vim.g.enable_autoformat = not vim.g.enable_autoformat
    end
end, {
    desc = "Toggle auto reformat on save",
    bang = true,
})
