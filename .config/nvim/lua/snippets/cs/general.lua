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
local cs_utils = require("snippets.cs.utils")

return {
    s(
        {
            trig = "namespace",
            desc = "File-scoped namespace",
        },
        fmta("namespace <>;", {
            i(1, "Namespace"),
        })
    ),
    s(
        {
            trig = "class",
            desc = "Class",
        },
        fmta(
            [[
            <> class <>
            {
                <>
            }
            ]],
            {
                cs_utils.visibility_choice(1),
                i(2, "ClassName"),
                i(0),
            }
        )
    ),
    s(
        {
            trig = "method",
            desc = "Method",
        },
        fmta(
            [[
            <> <> <>(<>)
            {
                <>
            }
            ]],
            {
                cs_utils.visibility_choice(1),
                i(2, "ReturnType"),
                i(3, "Name"),
                i(4),
                i(0),
            }
        )
    ),
    s(
        {
            trig = "property",
            desc = "Property",
        },
        fmta(
            [[
            <> <> <> { get; <>; }
            ]],
            {
                cs_utils.visibility_choice(1),
                i(2, "Type"),
                i(3, "Name"),
                c(4, {
                    t("set"),
                    t("private set"),
                    t("init"),
                    t("private init"),
                }),
            }
        )
    ),
    s(
        {
            trig = "field",
            desc = "Field",
        },
        fmta(
            [[
            <> <><><> <>;
            ]],
            {
                cs_utils.visibility_choice(1),
                c(2, {
                    t("readonly"),
                    t(""),
                }),
                f(function(args)
                    if #args[1][1] > 0 then
                        return " "
                    end
                    return ""
                end, { 2 }),
                i(3, "Type"),
                i(4, "Name"),
            }
        )
    ),
    s(
        {
            trig = "if",
            desc = "If statement",
        },
        fmta(
            [[
            if (<>)
            {
                <>
            }
            ]],
            {
                i(1),
                i(0),
            }
        )
    ),
}
