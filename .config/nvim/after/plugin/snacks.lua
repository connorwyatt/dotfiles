local whichKey = require("which-key")

whichKey.add({
    { "<leader>s", group = "Search" },
    {
        "<leader>s'",
        function()
            Snacks.picker.marks()
        end,
        desc = "Marks",
    },
    {
        "<leader>s,",
        function()
            Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
        end,
        desc = "Config files",
    },
    {
        "<leader>s/",
        function()
            Snacks.picker.grep()
        end,
        desc = "Grep",
    },
    {
        "<leader>sS",
        function()
            Snacks.picker.lsp_workspace_symbols()
        end,
        desc = "LSP workspace symbols",
    },
    {
        "<leader>sb",
        function()
            Snacks.picker.buffers()
        end,
        desc = "Buffers",
    },
    {
        "<leader>sd",
        function()
            Snacks.picker.diagnostics_buffer()
        end,
        desc = "Buffer diagnostics",
    },
    {
        "<leader>sD",
        function()
            Snacks.picker.diagnostics()
        end,
        desc = "Diagnostics",
    },
    {
        "<leader>sf",
        function()
            Snacks.picker.files()
        end,
        desc = "Files",
    },
    { "<leader>sg", group = "Git" },
    {
        "<leader>sgS",
        function()
            Snacks.picker.git_stash()
        end,
        desc = "Stash",
    },
    {
        "<leader>sgb",
        function()
            Snacks.picker.git_branches()
        end,
        desc = "Branches",
    },
    {
        "<leader>sgd",
        function()
            Snacks.picker.git_diff()
        end,
        desc = "Diff",
    },
    {
        "<leader>sgf",
        function()
            Snacks.picker.git_files()
        end,
        desc = "Files",
    },
    { "<leader>sgl", group = "Log" },
    {
        "<leader>sgla",
        function()
            Snacks.picker.git_log()
        end,
        desc = "Repository",
    },
    {
        "<leader>sglf",
        function()
            Snacks.picker.git_log_file()
        end,
        desc = "File",
    },
    {
        "<leader>sgll",
        function()
            Snacks.picker.git_log_line()
        end,
        desc = "Line",
    },
    {
        "<leader>sgs",
        function()
            Snacks.picker.git_status()
        end,
        desc = "Status",
    },
    {
        "<leader>sh",
        function()
            Snacks.picker.help()
        end,
        desc = "Help pages",
    },
    {
        "<leader>si",
        function()
            Snacks.picker.icons()
        end,
        desc = "Icons",
    },
    {
        "<leader>sl",
        function()
            Snacks.picker.lines()
        end,
        desc = "Lines",
    },
    {
        "<leader>sq",
        function()
            Snacks.picker.qflist()
        end,
        desc = "Quickfix",
    },
    {
        "<leader>sr",
        function()
            Snacks.picker.recent()
        end,
        desc = "Recent",
    },
    {
        "<leader>st",
        function()
            Snacks.picker.treesitter()
        end,
        desc = "Treesitter",
    },
    {
        "<leader>ss",
        function()
            Snacks.picker.lsp_symbols()
        end,
        desc = "LSP symbols",
    },
    {
        "<leader>sw",
        function()
            Snacks.picker.grep_word()
        end,
        desc = "Visual selection or word",
        mode = { "n", "x" },
    },
    {
        '<leader>s"',
        function()
            Snacks.picker.registers()
        end,
        desc = "Registers",
    },
    {
        "<leader>su",
        function()
            Snacks.picker.undo()
        end,
        desc = "Undo",
    },

    {
        "<leader>go",
        function()
            Snacks.gitbrowse.open()
        end,
        desc = "Open in browser",
    },

    {
        "<leader>gl",
        function()
            Snacks.lazygit.open()
        end,
        desc = "Open lazygit",
    },
})
