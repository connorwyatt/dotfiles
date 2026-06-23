local themes = require("helpers.themes")

local theme = "Sakura Night"
vim.api.nvim_set_option_value("background", "dark", {})
vim.cmd("colorscheme " .. themes.get_theme_name(theme))
