return {
    {
        "A7Lavinraj/fyler.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        branch = "stable",
        lazy = false,
        keys = {
            { "<leader><leader>", "<cmd>:Fyler<cr>", desc = "File browser" },
        },
        opts = {
            integrations = {
                icon = "nvim_web_devicons",
            },
            views = {
                finder = {
                    default_explorer = true,
                },
            },
        },
    },
}
