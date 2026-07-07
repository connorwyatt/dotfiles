local cw = require("helpers.cw")
local command_palette = require("helpers.command-palette")

local M = {}

local project_configuration_file_name = "project-config.lua"

_G.cw.project_configuration_loaded = false
_G.cw.project_configuration_cache = nil

local function get_file_path()
    local cw_dir = vim.fs.find(cw.directory_name, { upward = true, stop = vim.uv.os_homedir() })[1]
    if not cw_dir then
        return nil
    end

    return vim.fs.joinpath(cw_dir, project_configuration_file_name)
end

local function load_project_configuration()
    if _G.cw.project_configuration_loaded then
        return _G.cw.project_configuration_cache
    end

    local file_path = get_file_path()

    if file_path == nil then
        return _G.cw.project_configuration_cache
    end

    if vim.loop.fs_stat(file_path) then
        local ok, content = pcall(vim.secure.read, file_path)
        if ok and content then
            _G.cw.project_configuration_loaded = true
            _G.cw.project_configuration_cache = loadstring(content)()
        end
    end

    return _G.cw.project_configuration_cache
end

local function execute_project_configuration_hook(hook_name, ctx)
    local project_configuration = load_project_configuration()

    if project_configuration == nil or project_configuration[hook_name] == nil then
        return
    end

    project_configuration[hook_name](ctx)
end

function M.execute_init_hook()
    execute_project_configuration_hook("init")
end

function M.execute_loaded_hook()
    execute_project_configuration_hook("loaded", {
        command_palette = {
            register_command_definition = command_palette.register_command_definition,
            register_toggle_command_definition = command_palette.register_toggle_command_definition,
        },
    })
end

return M
