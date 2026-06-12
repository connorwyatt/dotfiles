return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        cond = function()
            return not _G.cw.is_obsidian_vault
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {
            file_types = { "markdown" },
            completions = {
                lsp = {
                    enabled = true,
                },
            },
        },
    },
}
