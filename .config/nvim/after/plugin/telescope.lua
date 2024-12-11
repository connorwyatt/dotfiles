require("telescope").setup {
    defaults = {
        layout_strategy = "center",
        layout_config = { prompt_position = "top", anchor = "N" },
    },
}

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fgf", builtin.git_files, { desc = "Find git files" })
vim.keymap.set("n", "<leader>fgb", builtin.git_branches, { desc = "Find git branches" })
vim.keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "Find live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help tags" })
vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Find recent files" })
vim.keymap.set("n", "<leader>ft", builtin.treesitter, { desc = "Find treesitter" })
vim.keymap.set("n", "<leader>fd", builtin.lsp_document_symbols, { desc = "Find LSP document symbols" })
vim.keymap.set("n", "<leader>fw", builtin.lsp_dynamic_workspace_symbols, { desc = "Find LSP workspace symbols" })
vim.keymap.set("n", "<leader>fj", builtin.jumplist, { desc = "Find jumplist" })
vim.keymap.set("n", "<leader>fc", builtin.current_buffer_fuzzy_find, { desc = "Find in open buffer" })
