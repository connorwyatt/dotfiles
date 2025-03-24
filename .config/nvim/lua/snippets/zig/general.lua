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

return {
    s(
        {
            trig = "import",
            desc = "Import statement",
        },
        fmta(
            '<> <> = @import("<>");',
            {
                c(1, {
                    t("const"),
                    t("var"),
                }),
                d(3, function(args)
                        local module_lines = args[1]

                        if not module_lines then
                            return sn(nil, {})
                        end

                        local module = module_lines[1]

                        -- TODO: Make this account for slashes etc.
                        local default_identifier = module:gsub("\\.zig$", "")

                        return sn(nil, {
                            i(1, default_identifier),
                        })
                    end,
                    { 2 }),
                i(2),
            }
        )
    ),
    s(
        {
            trig = "std",
            desc = "Import std",
        },
        fmta(
            'const std = @import("std");',
            {}
        )
    ),
    s(
        {
            trig = "print",
            desc = "Print using std.debug",
        },
        fmta(
            'std.debug.print("<>", .{<>});',
            {
                i(1, "message"),
                d(2, function(args)
                    if not args[1][1]:find("{.*}") then
                        return sn(nil, {})
                    end

                    return sn(
                        nil,
                        fmta(
                            " <> ",
                            {
                                i(1),
                            }
                        )
                    )
                end, { 1 }),
            }
        )
    ),
    s(
        {
            trig = "struct",
            desc = "Struct",
        },
        fmta(
            [[
            <> <> = struct {
                <>
            };
            ]],
            {
                c(1, {
                    t("const"),
                    t("pub const"),
                }),
                i(2, "StructName"),
                i(0),
            }
        )
    ),
    s(
        {
            trig = "function",
            desc = "Function",
        },
        fmta(
            [[
            <> <>(<>) <> {
                <>
            }
            ]],
            {
                c(1, {
                    t("fn"),
                    t("pub fn"),
                }),
                i(2, "functionName"),
                i(3),
                i(4, "void"),
                i(0),
            }
        )
    ),
    s(
        {
            trig = "switch",
            desc = "Switch expression",
        },
        fmta(
            [[
            switch (<>) {
                <>
            };
            ]],
            {
                d(1, utils.visual_selection_or_insert()),
                i(0),
            }
        )
    ),
    s(
        {
            trig = "arraylist",
            desc = "Array list",
        },
        fmta(
            'std.ArrayList(<>).init();',
            {
                i(1, "Type"),
            }
        )
    ),
    s(
        {
            trig = "test",
            desc = "Test",
        },
        fmta(
            [[
            test "<>" {
                const testing = std.testing;

                <>
            }
            ]],
            {
                i(1, "test name"),
                i(0),
            }
        )
    ),
    s(
        {
            trig = "testing",
            desc = "Import testing",
        },
        {
            t("const testing = std.testing;"),
        }
    ),
}
