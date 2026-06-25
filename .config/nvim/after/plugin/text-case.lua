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