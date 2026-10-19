return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        init = function()
            vim.highlight.priorities.semantic_tokens = 95 -- Or any number lower than 100, treesitter's priority level
        end,
        config = function()
            local treesitter = require("nvim-treesitter")

            treesitter.install("comment")

            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("nvim-treesitter-enable", { clear = true }),
                callback = function(args)
                    local lang = vim.treesitter.language.get_lang(args.match)
                    if not lang or not vim.list_contains(treesitter.get_available(), lang) then
                        return
                    end

                    local function enable()
                        if not vim.api.nvim_buf_is_valid(args.buf) then
                            return
                        end
                        if not pcall(vim.treesitter.start, args.buf, lang) then
                            return
                        end
                        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end

                    if vim.list_contains(treesitter.get_installed(), lang) then
                        enable()
                        return
                    end

                    treesitter.install(lang):await(function(err, success)
                        if err or not success then
                            return
                        end
                        enable()
                    end)
                end,
            })
        end,
    },
    {
        "casey/tree-sitter-just",
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
