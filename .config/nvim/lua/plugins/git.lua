return {
    { "lewis6991/gitsigns.nvim", },
    {
        "pwntester/octo.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "folke/snacks.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            picker = "snacks",
        },
    },
}
