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
    TextCaseSnake = "to_snake_case",
    TextCaseCamel = "to_camel_case",
    TextCasePascal = "to_pascal_case",
    TextCaseDash = "to_dash_case",
    TextCaseConstant = "to_constant_case",
    TextCaseUpper = "to_upper_case",
    TextCaseLower = "to_lower_case",
    TextCaseDot = "to_dot_case",
    TextCaseTitle = "to_title_case",
    TextCasePath = "to_path_case",
}

for name, method in pairs(commands) do
    vim.api.nvim_create_user_command(name, function()
        require("textcase").quick_replace(method)
    end, { range = true })
end