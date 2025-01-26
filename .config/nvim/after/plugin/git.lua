local gitsigns = require("gitsigns")
local whichKey = require("which-key")

whichKey.add({
    { "[g", hidden = true, },
    { "]g", hidden = true, },
})

gitsigns.setup({
    signcolumn              = true,
    numhl                   = true,
    linehl                  = false,
    word_diff               = false,
    current_line_blame      = true,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 0,
        ignore_whitespace = true,
        virt_text_priority = 100,
        use_focus = true,
    },
    on_attach               = function()
        whichKey.add({
            { "<leader>g",  group = "Git", },
            { "<leader>gt", group = "Toggles", },
        })

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "[g", function()
            if vim.wo.diff then
                vim.cmd.normal({ "[g", bang = true })
            else
                gitsigns.nav_hunk("prev")
            end
        end, { desc = "Previous git hunk" })

        map("n", "]g", function()
            if vim.wo.diff then
                vim.cmd.normal({ "]g", bang = true })
            else
                gitsigns.nav_hunk("next")
            end
        end, { desc = "Next git hunk" })

        -- Actions
        map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Git hunk preview" })
        map("n", "<leader>gi", gitsigns.preview_hunk_inline, { desc = "Inline git hunk preview" })
        map("n", "<leader>gb",
            gitsigns.blame
            , { desc = "File blame" })
        map("n", "<leader>gl", function()
            gitsigns.blame_line({ full = true })
        end)
        map("n", "<leader>gd", gitsigns.diffthis, { desc = "Line blame" })

        -- Toggles
        map("n", "<leader>gtb", gitsigns.toggle_current_line_blame,
            { desc = "Toggle current line blame" })
        map("n", "<leader>gtd", function()
            gitsigns.toggle_linehl()
            gitsigns.toggle_deleted()
            gitsigns.toggle_word_diff()
        end, { desc = "Toggle inline diff" })

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select git hunk" })
    end
})
