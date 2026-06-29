return {
    "petertriho/nvim-scrollbar",
    event = "VeryLazy",
    dependencies = {
        "kevinhwang91/nvim-hlslens",
        -- "lewis6991/gitsigns.nvim",
    },
    opts = {
        set_highlights = false,
        handle = {
            blend = 0,
        },
        handlers = {
            cursor = true,
            diagnostic = true,
            handle = true,
        },
    },
    config = function(_, opts)
        require("scrollbar").setup(opts)
        -- require("scrollbar.handlers.gitsigns").setup()
        require("scrollbar.handlers.search").setup({
            override_lens = function() end,
        })
    end,
}
