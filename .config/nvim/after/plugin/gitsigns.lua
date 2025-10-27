local gitsigns = require("gitsigns")
local whichKey = require("which-key")

whichKey.add({
    { "[g", hidden = true },
    { "]g", hidden = true },
})

gitsigns.setup({
    signs_staged_enable = true,
    signcolumn = true,
    numhl = false,
    linehl = false,
    word_diff = false,
    attach_to_untracked = true,
    current_line_blame = false,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 0,
        ignore_whitespace = false,
        virt_text_priority = 100,
        use_focus = true,
    },
    on_attach = function()
        whichKey.add({
            { "<leader>g", group = "Git" },
            { "<leader>gt", group = "Toggles" },
        })

        local function map(mode, l, r, opts)
            opts = opts or {}
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "[g", function()
            if vim.wo.diff then
                vim.cmd.normal({ "[g", bang = true })
            else
                gitsigns.nav_hunk("prev")
            end
        end, { desc = "Previous hunk" })

        map("n", "]g", function()
            if vim.wo.diff then
                vim.cmd.normal({ "]g", bang = true })
            else
                gitsigns.nav_hunk("next")
            end
        end, { desc = "Next hunk" })

        -- Actions
        map("n", "<leader>gs", gitsigns.stage_hunk, { desc = "Stage hunk" })
        map("n", "<leader>gr", gitsigns.reset_hunk, { desc = "Reset hunk" })

        map("v", "<leader>gs", function()
            gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Stage hunk" })

        map("v", "<leader>gr", function()
            gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Reset hunk" })

        map("n", "<leader>gS", gitsigns.stage_buffer, { desc = "Stage buffer" })
        map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "Reset buffer" })

        map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Hunk preview" })
        map("n", "<leader>gi", gitsigns.preview_hunk_inline, { desc = "Inline hunk preview" })
        map("n", "<leader>gb", gitsigns.blame, { desc = "File blame" })
        map("n", "<leader>gl", function()
            gitsigns.blame_line({ full = true })
        end, { desc = "Line blame" })
        map("n", "<leader>gd", gitsigns.diffthis, { desc = "Line blame" })

        -- Toggles
        map("n", "<leader>gtb", gitsigns.toggle_current_line_blame, { desc = "Toggle current line blame" })
        map("n", "<leader>gtd", function()
            gitsigns.toggle_linehl()
            gitsigns.toggle_deleted()
            gitsigns.toggle_word_diff()
        end, { desc = "Toggle inline diff" })
    end,
})
