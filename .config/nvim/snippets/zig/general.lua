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

return {
    s(
        {
            trig = "print",
            desc = "Print using std.debug",
        },
        {
            t('std.debug.print("'),
            i(1, "message"),
            t('", .{'),
            d(2, function(args)
                if not args[1][1]:find("{.*}") then
                    return sn(nil, {})
                end

                return sn(nil, {
                    i(1),
                })
            end, { 1 }),
            t('});'),
        }
    ),
    s(
        {
            trig = "struct",
            desc = "Struct",
        },
        {
            c(1, {
                t("const "),
                t("pub const "),
            }),
            i(2, "StructName"),
            t({ " = struct {", "\t", }),
            i(0),
            t({ "", "};" }),
        }
    ),
    s(
        {
            trig = "arraylist",
            desc = "Array list",
        },
        {
            t("std.ArrayList("),
            i(1, "Type"),
            t(").init();"),
        }
    ),
}
