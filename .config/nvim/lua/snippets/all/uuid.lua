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
local utils = require("snippets.utils")

local function execute_shell_command(command)
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

return {
    s(
        {
            trig = "uuid",
            desc = "Generate a uuid",
        },
        {
            d(1, function()
                local uuid = execute_shell_command("uuidgen")[1]

                return sn(nil, {
                    c(1, {
                        t(uuid:lower()),
                        t(uuid:upper()),
                    })
                })
            end),
        }
    ),
}
