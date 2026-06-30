local command_palette = require("helpers.command-palette")
local inline_diagnostic = require("tiny-inline-diagnostic")

command_palette.register_toggle_command_definition("Inline diagnostics", function()
    return require("tiny-inline-diagnostic.state").user_toggle_state
end, function(enabled)
    if enabled then
        inline_diagnostic.enable()
    else
        inline_diagnostic.disable()
    end
end)
