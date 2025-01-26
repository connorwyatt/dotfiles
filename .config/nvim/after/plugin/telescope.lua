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
        prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
        results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
        preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
}

telescope.setup({
    defaults = dropdown,
    extensions = {
        ["ui-select"] = {
            dropdown,
        },
    },
})

telescope.load_extension("fzf")
telescope.load_extension("ui-select")

whichKey.add({
    { "<leader>s",  group = "Search" },

    { "<leader>sf", builtin.find_files,                    desc = "Search files" },
    { "<leader>si", builtin.live_grep,                     desc = "Search in files" },
    { "<leader>sc", builtin.current_buffer_fuzzy_find,     desc = "Search in current file" },

    { "<leader>sg", builtin.git_files,                     desc = "Search git files" },
    { "<leader>sd", builtin.git_status,                    desc = "Search git diff" },

    { "<leader>sr", builtin.oldfiles,                      desc = "Search recent files" },

    { "<leader>st", builtin.treesitter,                    desc = "Search treesitter" },

    { "<leader>ss", builtin.lsp_document_symbols,          desc = "Search current file symbols" },
    { "<leader>sw", builtin.lsp_dynamic_workspace_symbols, desc = "Search project symbols" },

    { "<leader>sl", builtin.resume,                        desc = "Resume last search" },
})
