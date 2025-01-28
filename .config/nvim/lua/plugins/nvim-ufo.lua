return {
    {
        "kevinhwang91/nvim-ufo",
        dependencies = {
            "kevinhwang91/promise-async",
        },
        opts = {
            close_fold_kinds_for_ft = {
                default = { 'imports', 'comment' },
            },
            provider_selector = function()
                return { 'treesitter', 'indent', }
            end,
            -- fold_virt_text_handler = function(virtualText, startLineNumber, endLineNumber, width, truncate)
            --     return virtualText
            -- end
        },
    },
}
