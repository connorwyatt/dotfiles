local M = {}

local theme_lookup = {}

local function to_kebab_case(name)
    return name:lower():gsub("%s+", "-")
end

local function load_themes(path)
    local ok, lines = pcall(vim.fn.readfile, vim.fn.expand(path))
    if not ok then
        return
    end

    for _, line in ipairs(lines) do
        local name = line:match("^%s*(.-)%s*$")
        if name and name ~= "" then
            theme_lookup[name] = to_kebab_case(name)
        end
    end
end

load_themes("~/.bin/themes-dark.txt")
load_themes("~/.bin/themes-light.txt")

function M.get_theme_name(display_name)
    return theme_lookup[display_name]
end

return M