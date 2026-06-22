local M = {}

M.directory_name = ".cw"

function M.ensure_cw_directory()
    local cw_path = vim.fs.joinpath(vim.fn.getcwd(), M.directory_name)
    vim.fn.mkdir(cw_path, "p")
end

return M
