local lualine = require("lualine")
local noice = require("noice")

local neotree_filename_prefix = "neo-tree filesystem"
local filename_fmt = function(str)
    local is_neotree_file = str:sub(1, #neotree_filename_prefix) == neotree_filename_prefix
    if not is_neotree_file then
        return str
    else
        return "File browser"
    end
end

lualine.setup({
    options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = "|",
        section_separators = "",
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {
            statusline = 100,
            tabline = 100,
            winbar = 100,
        }
    },
    sections = {
        lualine_a = { "mode", },
        lualine_b = {
            "branch",
            "diff",
        },
        lualine_c = {
            {
                "filename",
                path = 1,
                file_status = false,
                fmt = filename_fmt,
            },
        },
        lualine_x = {
            {
                noice.api.statusline.mode.get,
                cond = noice.api.statusline.mode.has,
            },
        },
        lualine_y = { "diagnostics", "encoding", "filetype", },
        lualine_z = { "location", },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {
            {
                "filename",
                path = 1,
                file_status = false,
                fmt = filename_fmt,
            },
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = { "diagnostics", "encoding", "filetype", },
        lualine_z = { "location", },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
    },
})
