local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

local M = {}

M.execute_shell_command = function(command)
    local file = io.popen(command, "r")
    local res = {}

    if file == nil then
        return res
    end

    for line in file:lines() do
        table.insert(res, line)
    end

    return res
end

M.visual_selection_or_insert = function(default_insert_text)
    return function(args, parent)
        if #parent.snippet.env.LS_SELECT_RAW > 0 then
            return sn(nil, t(parent.snippet.env.LS_SELECT_RAW))
        else
            return sn(nil, i(1, default_insert_text))
        end
    end
end

M.load_local = function(filetype, load_file)
    local local_path = vim.fn.stdpath("config") .. "/lua/snippets/" .. filetype .. "/local"
    local paths = {}

    if vim.fn.isdirectory(local_path) == 1 then
        for name, type in vim.fs.dir(local_path) do
            if type == "file" and vim.endswith(name, ".lua") then
                table.insert(paths, local_path .. "/" .. name)
            end
        end
    end

    table.sort(paths)

    local snippets = {}
    local autosnippets = {}

    for _, path in ipairs(paths) do
        local file_snippets, file_autosnippets = load_file(path)
        vim.list_extend(snippets, file_snippets or {})
        vim.list_extend(autosnippets, file_autosnippets or {})
    end

    return snippets, autosnippets
end

return M
