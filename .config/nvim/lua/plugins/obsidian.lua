return {
    {
        "obsidian-nvim/obsidian.nvim",
        version = "*",
        cond = function()
            return _G.cw.is_obsidian_vault
        end,
        ---@module 'obsidian'
        ---@type obsidian.config
        opts = {
            legacy_commands = false,
            ui = {
                enable = false,
            },
            workspaces = {
                {
                    name = "notes",
                    path = "~/Code/notes",
                },
            },
            picker = {
                name = "snacks.picker",
            },
        },
    },
}
