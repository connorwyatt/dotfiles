local cw = require("helpers.cw")

local M = {}

local project_specific_shada_directories = {
    "~/Code",
    "~/.config",
}

local function project_specific_shada_file_location()
    return vim.fs.joinpath(vim.fn.getcwd(), cw.directory_name, "project.shada")
end

local function is_under_directory(cwd, directory)
    directory = vim.fs.normalize(vim.fn.expand(directory))
    cwd = vim.fs.normalize(cwd)

    return cwd == directory or vim.startswith(cwd, directory .. "/")
end

local function is_in_project_specific_shada_directory()
    local cwd = vim.fn.getcwd()

    for _, directory in ipairs(project_specific_shada_directories) do
        if is_under_directory(cwd, directory) then
            return true
        end
    end

    return false
end

local function is_editing_commit_message()
    for _, arg in ipairs(vim.fn.argv()) do
        if type(arg) == "string" and not vim.startswith(arg, "-") then
            local path = vim.fs.normalize(arg)
            if vim.endswith(path, ".git/COMMIT_EDITMSG") then
                return true
            end
        end
    end

    return false
end

local function should_use_project_specific_shada()
    if is_editing_commit_message() then
        return false
    end

    if is_in_project_specific_shada_directory() then
        return true
    end

    local shada_path = project_specific_shada_file_location()
    if vim.uv.fs_stat(shada_path) then
        return true
    end

    return false
end

function register_shada_sync_autocommands()
    local shada_sync_group = vim.api.nvim_create_augroup("ShadaSync", { clear = true })

    vim.api.nvim_create_autocmd({ "FocusLost", "VimLeave" }, {
        group = shada_sync_group,
        callback = function()
            pcall(vim.cmd, "wshada")
        end,
    })

    vim.api.nvim_create_autocmd({ "FocusGained", "VimEnter" }, {
        group = shada_sync_group,
        callback = function()
            pcall(vim.cmd, "rshada")
        end,
    })
end

function M.initialise_shada()
    if not should_use_project_specific_shada() then
        return
    end

    cw.ensure_cw_directory()

    vim.o.shadafile = project_specific_shada_file_location()

    register_shada_sync_autocommands()
end

return M
