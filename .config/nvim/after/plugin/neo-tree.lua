require("neo-tree").setup({
    window = {
        position = "current",
    },
    follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
    },
    group_empty_dirs = true,
    filesystem = {
        hijack_netrw_behavior = "disabled",
    },
})

vim.keymap.set("n", "<leader>pv", "<cmd>:Neotree<cr>", { desc = "Neotree" })
