local M = {}

local command_definitions = {}

local function resolve(value)
    if type(value) == "function" then
        return value()
    end
    return value
end

local function open_command_palette_picker()
    local items = {}

    for _, command_definition in ipairs(command_definitions) do
        table.insert(items, {
            text = resolve(command_definition.text),
            action = command_definition.action,
        })
    end

    Snacks.picker({
        title = "Command Palette",
        layout = { preset = "vscode", preview = false },
        items = items,
        format = "text",
        confirm = function(picker, item)
            picker:close()
            if type(item.action) == "string" then
                if item.action:find("^:") then
                    vim.cmd(item.action:sub(2))
                else
                    vim.api.nvim_input(vim.api.nvim_replace_termcodes(item.action, true, true, true))
                end
            else
                item.action()
            end
        end,
    })
end

function M.initialise_command_palette()
    local which_key = require("which-key")
    which_key.add({
        {
            "<C-p>",
            open_command_palette_picker,
            mode = { "n", "i", "v" },
            desc = "Open Command Palette",
        },
    })
end

function M.register_command_definition(text, action)
    table.insert(command_definitions, { text = text, action = action })
end

local vim_option_scopes = {
    [vim.o] = true,
    [vim.go] = true,
    [vim.wo] = true,
    [vim.bo] = true,
}

---@param text string
---@param opts vim.o|vim.wo|vim.bo
---@param key string
---@overload fun(text: string, getter: fun(): boolean, setter: fun(boolean))
function M.register_toggle_command_definition(text, opts, key)
    local getter, setter

    if vim_option_scopes[opts] and type(key) == "string" then
        getter = function()
            return opts[key]
        end
        setter = function(value)
            opts[key] = value
        end
    else
        getter = opts
        setter = key
    end

    M.register_command_definition(function()
        local value = getter()
        local label = value and "(On)" or "(Off)"
        return text .. " " .. label
    end, function()
        setter(not getter())
    end)
end

return M
