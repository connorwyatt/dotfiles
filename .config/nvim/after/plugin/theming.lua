local themes = require("helpers.themes")

local theme = "Rose Pine Moon"
vim.api.nvim_set_option_value("background", "dark", {})
vim.cmd("colorscheme " .. themes.get_theme_name(theme))
