local telescope = require("telescope")
local builtin = require("telescope.builtin")
local whichKey = require("which-key")

local dropdown = {
    results_title = false,
    sorting_strategy = "ascending",
    prompt_position = "top",
    layout_strategy = "center",
    layout_config = {
        prompt_position = "top",
        anchor = "N",
        preview_cutoff = 1,

        width = function(_, max_columns, _)
            return math.min(max_columns, 120)
        end,

        height = function(_, _, max_lines)
            return math.min(max_lines, 15)
        end,
    },
    border = true,
    borderchars = {
        prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
        results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
        preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    },
}

telescope.setup({
    defaults = vim.tbl_extend("keep", {
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--trim",
        },
    }, dropdown),
})

telescope.load_extension("fzf")
telescope.load_extension("ui-select")

whichKey.add({
    { "<leader>s",  group = "Search" },
    { "<leader>s'", builtin.marks,                         desc = "Marks", },
    { "<leader>s/", builtin.live_grep,                     desc = "Grep", },
    { "<leader>sB", builtin.buffers,                       desc = "Buffers", },
    { "<leader>sC", builtin.command_history,               desc = "Command history", },
    { "<leader>sH", builtin.highlights,                    desc = "Highlights", },
    { "<leader>sL", builtin.search_history,                desc = "Search history", },
    { "<leader>sS", builtin.lsp_dynamic_workspace_symbols, desc = "LSP workspace symbols", },
    { "<leader>sb", builtin.current_buffer_fuzzy_find,     desc = "Current buffer", },
    { "<leader>sc", builtin.commands,                      desc = "Commands", },
    { "<leader>sd", builtin.git_status,                    desc = "Git diff", },
    { "<leader>sf", builtin.find_files,                    desc = "Files", },
    { "<leader>sg", builtin.git_files,                     desc = "Git files", },
    { "<leader>sh", builtin.help_tags,                     desc = "Help", },
    { "<leader>sl", builtin.resume,                        desc = "Resume last search", },
    { "<leader>sr", builtin.oldfiles,                      desc = "Recent files", },
    { "<leader>ss", builtin.lsp_document_symbols,          desc = "LSP document symbols", },
    { "<leader>st", builtin.treesitter,                    desc = "Treesitter", },
    { '<leader>s"', builtin.registers,                     desc = "Registers", },
})
