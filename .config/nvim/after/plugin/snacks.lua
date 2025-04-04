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
        "<leader>s/",
        function()
            Snacks.picker.grep()
        end,
        desc = "Grep",
    },
    {
        "<leader>sC",
        function()
            Snacks.picker.command_history()
        end,
        desc = "Command history",
    },
    {
        "<leader>sH",
        function()
            Snacks.picker.highlights()
        end,
        desc = "Highlights",
    },
    {
        "<leader>sP",
        function()
            Snacks.picker.projects()
        end,
        desc = "Projects",
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
        "<leader>sc",
        function()
            Snacks.picker.commands()
        end,
        desc = "Commands",
    },
    {
        "<leader>sf",
        function()
            Snacks.picker.files()
        end,
        desc = "Find files",
    },
    {
        "<leader>sg",
        function()
            Snacks.picker.git_files()
        end,
        desc = "Find git files",
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
            Snacks.picker.resume()
        end,
        desc = "Last search",
    },
    {
        "<leader>sp",
        function()
            Snacks.picker.lazy()
        end,
        desc = "Plugin",
    },
    {
        "<leader>sr",
        function()
            Snacks.picker.recent()
        end,
        desc = "Recent",
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
        "[w",
        function()
            Snacks.words.jump(-1)
        end,
        desc = "Previous word occurrence",
    },
    {
        "]w",
        function()
            Snacks.words.jump(1)
        end,
        desc = "Next word occurrence",
    },
})
