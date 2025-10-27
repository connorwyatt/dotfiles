return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            max_lines = 3,
        },
    },
}
