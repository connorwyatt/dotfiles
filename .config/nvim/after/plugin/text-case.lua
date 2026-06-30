local command_palette = require("helpers.command-palette")

local telescope_commands = {
    "TextCaseOpenTelescope",
    "TextCaseOpenTelescopeQuickChange",
    "TextCaseOpenTelescopeLSPChange",
}

local function remove_telescope_commands()
    for _, name in ipairs(telescope_commands) do
        pcall(vim.api.nvim_del_user_command, name)
    end
end

vim.api.nvim_create_autocmd("User", {
    pattern = "LazyLoad",
    callback = function(event)
        if event.data == "text-case.nvim" then
            vim.schedule(remove_telescope_commands)
        end
    end,
})

local commands = {
    { name = "TextCaseSnake", method = "to_snake_case", label = "Text case: snake_case" },
    { name = "TextCaseCamel", method = "to_camel_case", label = "Text case: camelCase" },
    { name = "TextCasePascal", method = "to_pascal_case", label = "Text case: PascalCase" },
    { name = "TextCaseDash", method = "to_dash_case", label = "Text case: kebab-case" },
    { name = "TextCaseConstant", method = "to_constant_case", label = "Text case: CONSTANT_CASE" },
    { name = "TextCaseUpper", method = "to_upper_case", label = "Text case: UPPER CASE" },
    { name = "TextCaseLower", method = "to_lower_case", label = "Text case: lower case" },
    { name = "TextCaseDot", method = "to_dot_case", label = "Text case: dot.case" },
    { name = "TextCaseTitle", method = "to_title_case", label = "Text case: Title Case" },
    { name = "TextCasePath", method = "to_path_case", label = "Text case: path/case" },
}

for _, command in ipairs(commands) do
    vim.api.nvim_create_user_command(command.name, function()
        require("textcase").quick_replace(command.method)
    end, { range = true })

    command_palette.register_command_definition(command.label, ":" .. command.name)
end