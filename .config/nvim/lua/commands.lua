local command_palette = require("helpers.command-palette")

local M = {}

function M.register()
    command_palette.register_toggle_command_definition("Word wrap (global)", vim.o, "wrap")
    command_palette.register_toggle_command_definition("Word wrap (window)", vim.wo, "wrap")
    command_palette.register_toggle_command_definition("Invisible characters (global)", vim.o, "list")
    command_palette.register_toggle_command_definition("Invisible characters (window)", vim.wo, "list")

    command_palette.register_toggle_command_definition("Relative line numbers", vim.wo, "relativenumber")
    command_palette.register_toggle_command_definition("Line numbers", vim.wo, "number")
    command_palette.register_toggle_command_definition("Cursor line", vim.wo, "cursorline")
    command_palette.register_toggle_command_definition("Folding", vim.wo, "foldenable")
    command_palette.register_toggle_command_definition("Spell check", vim.wo, "spell")

    command_palette.register_toggle_command_definition("Conceal", function()
        return vim.wo.conceallevel > 0
    end, function(enabled)
        vim.wo.conceallevel = enabled and 2 or 0
    end)
end

return M