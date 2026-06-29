local M = {}

M.themes = {
    dark = "sakura-night",
    light = "sakura-day",
}

function M.apply(mode)
    local theme = M.themes[mode]
    vim.api.nvim_set_option_value("background", mode, {})
    vim.cmd.colorscheme(theme)
end

return M