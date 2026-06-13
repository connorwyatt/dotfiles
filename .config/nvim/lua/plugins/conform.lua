return {
    {
        "stevearc/conform.nvim",
        config = true,
    },
    {
        "zapling/mason-conform.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            "stevearc/conform.nvim",
        },
    },
}
