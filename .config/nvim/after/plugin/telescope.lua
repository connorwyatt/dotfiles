local telescope = require("telescope")
local actions = require("telescope.actions")
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
        preview_cutoff = 20,

        width = function(_, max_columns, _)
            return math.min(max_columns, 120)
        end,

        height = function(_, _, max_lines)
            return math.min(max_lines, 20)
        end,
    },
    border = true,
    borderchars = {
        prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
        results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
        preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    },
}

local cursor = {
    theme = "cursor",
    sorting_strategy = "ascending",
    results_title = false,
    layout_strategy = "cursor",
    layout_config = {
        width = function(_, max_columns, _)
            return math.min(max_columns, 80)
        end,
        height = function(_, _, max_lines)
            return math.min(max_lines, 9)
        end,
    },
    borderchars = {
        prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
        results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
        preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    },
}

telescope.setup({
    defaults = {
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
        mappings = {
            i = {
                ["<esc>"] = actions.close,
            },
        },
    },
    pickers = {
        buffers = vim.tbl_extend(
            "force",
            { mappings = { i = { ["<C-d>"] = actions.delete_buffer + actions.move_to_top } } },
            dropdown
        ),
        command_history = dropdown,
        commands = dropdown,
        current_buffer_fuzzy_find = dropdown,
        find_files = dropdown,
        git_bcommits = dropdown,
        git_bcommits_range = dropdown,
        git_branches = dropdown,
        git_commits = dropdown,
        git_files = dropdown,
        git_status = dropdown,
        git_stash = dropdown,
        help_tags = dropdown,
        highlights = dropdown,
        live_grep = dropdown,
        lsp_document_symbols = dropdown,
        lsp_dynamic_workspace_symbols = dropdown,
        marks = dropdown,
        oldfiles = dropdown,
        registers = dropdown,
        resume = dropdown,
        search_history = dropdown,
        treesitter = dropdown,
    },
    extensions = {
        ["ui-select"] = cursor,
    },
})

telescope.load_extension("fzf")
telescope.load_extension("ui-select")

whichKey.add({
    { "<leader>s", group = "Search" },
    { "<leader>s'", builtin.marks, desc = "Marks" },
    { "<leader>s/", builtin.live_grep, desc = "Grep" },
    { "<leader>sB", builtin.buffers, desc = "Buffers" },
    { "<leader>sC", builtin.command_history, desc = "Command history" },
    { "<leader>sH", builtin.highlights, desc = "Highlights" },
    { "<leader>sL", builtin.search_history, desc = "Search history" },
    { "<leader>sS", builtin.lsp_dynamic_workspace_symbols, desc = "LSP workspace symbols" },
    { "<leader>sb", builtin.current_buffer_fuzzy_find, desc = "Current buffer" },
    { "<leader>sc", builtin.commands, desc = "Commands" },
    { "<leader>sf", builtin.find_files, desc = "Files" },
    { "<leader>s'", builtin.marks, desc = "Marks" },
    { "<leader>sg", group = "Git" },
    { mode = "v", "<leader>sgc", builtin.git_bcommits_range, desc = "Selection commits" },
    { mode = "n", "<leader>sgc", builtin.git_bcommits, desc = "Buffer commits" },
    { "<leader>sgC", builtin.git_commits, desc = "Commits" },
    { "<leader>sgb", builtin.git_branches, desc = "Branches" },
    { "<leader>sgd", builtin.git_status, desc = "Diff" },
    { "<leader>sgf", builtin.git_files, desc = "Files" },
    { "<leader>sgs", builtin.git_stash, desc = "Stashes" },
    { "<leader>sh", builtin.help_tags, desc = "Help" },
    { "<leader>sl", builtin.resume, desc = "Resume last search" },
    { "<leader>sr", builtin.oldfiles, desc = "Recent files" },
    { "<leader>ss", builtin.lsp_document_symbols, desc = "LSP document symbols" },
    { "<leader>st", builtin.treesitter, desc = "Treesitter" },
    { '<leader>s"', builtin.registers, desc = "Registers" },
})
