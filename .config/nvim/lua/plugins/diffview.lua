return {
    {
        "sindrets/diffview.nvim",
        opts = function()
            local actions = require("diffview.actions")

            return {
                view = {
                    default = {
                        winbar_info = true,
                    },
                },
                keymaps = {
                    view = {
                        {
                            "n",
                            "<s-tab>",
                            false,
                        },
                        {
                            "n",
                            "<tab>",
                            false,
                        },
                        {
                            "n",
                            "[f",
                            actions.select_prev_entry,
                            { desc = "Open the diff for the previous file" },
                        },
                        {
                            "n",
                            "]f",
                            actions.select_next_entry,
                            { desc = "Open the diff for the next file" },
                        },
                    },
                    file_panel = {
                        {
                            "n",
                            "<s-tab>",
                            false,
                        },
                        {
                            "n",
                            "<tab>",
                            false,
                        },
                        {
                            "n",
                            "[f",
                            actions.select_prev_entry,
                            { desc = "Open the diff for the previous file" },
                        },
                        {
                            "n",
                            "]f",
                            actions.select_next_entry,
                            { desc = "Open the diff for the next file" },
                        },
                    },
                    file_history_panel = {
                        {
                            "n",
                            "<s-tab>",
                            false,
                        },
                        {
                            "n",
                            "<tab>",
                            false,
                        },
                        {
                            "n",
                            "[f",
                            actions.select_prev_entry,
                            { desc = "Open the diff for the previous file" },
                        },
                        {
                            "n",
                            "]f",
                            actions.select_next_entry,
                            { desc = "Open the diff for the next file" },
                        },
                    },
                },
            }
        end,
    },
}
