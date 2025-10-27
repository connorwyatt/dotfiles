local luasnip = require("luasnip")
local luasnipTypes = require("luasnip.util.types")

luasnip.setup({
    update_events = { "TextChanged", "TextChangedI" },
    region_check_events = { "CursorMoved", "CursorMovedI" },
    store_selection_keys = "<Tab>",
    ext_opts = {
        [luasnipTypes.choiceNode] = {
            active = {
                hl_group = "LuasnipChoiceNodeActive",
                virt_text = { { "", "LuasnipChoiceNodeActiveVirtualText" } },
            },
            unvisited = {
                hl_group = "LuasnipChoiceNodeUnvisited",
                virt_text = { { "", "LuasnipChoiceNodeUnvisitedVirtualText" } },
            },
            visited = {
                hl_group = "LuasnipChoiceNodeVisited",
                virt_text = { { "", "LuasnipChoiceNodeVisitedVirtualText" } },
            },
        },
        [luasnipTypes.insertNode] = {
            active = {
                hl_group = "LuasnipInsertNodeActive",
                virt_text = { { "", "LuasnipInsertNodeActiveVirtualText" } },
            },
            unvisited = {
                hl_group = "LuasnipInsertNodeUnvisited",
                virt_text = { { "", "LuasnipInsertNodeUnvisitedVirtualText" } },
            },
            visited = {
                hl_group = "LuasnipInsertNodeVisited",
                virt_text = { { "", "LuasnipInsertNodeVisitedVirtualText" } },
            },
        },
    },
})

local load_luasnip_snippets = function()
    local loader = require("luasnip.loaders.from_lua")
    loader.clean()
    loader.lazy_load({
        paths = {
            vim.fn.stdpath("config") .. "/lua/snippets",
        },
    })
end

vim.api.nvim_create_user_command("ReloadSnippets", load_luasnip_snippets, {
    nargs = 0,
    desc = "Reload snippets",
})

load_luasnip_snippets()

local function set_choice_callback(_, indx)
    if not indx then
        return
    end
    vim.api.nvim_feedkeys("i", "x", false)
    luasnip.set_choice(indx)
    luasnip.jump(1)
end

local function select_choice()
    vim.ui.select(luasnip.get_current_choices(), { kind = "luasnip" }, set_choice_callback)
end

vim.keymap.set({ "i", "s" }, "<C-k>", function()
    if luasnip.choice_active() then
        select_choice()
    elseif luasnip.expandable() then
        luasnip.expand({})
    end
end)
vim.keymap.set({ "i", "s" }, "<C-l>", function()
    if luasnip.in_snippet() then
        luasnip.jump(1)
    end
end)
vim.keymap.set({ "i", "s" }, "<C-j>", function()
    if luasnip.in_snippet() then
        luasnip.jump(-1)
    end
end)
