local whichKey = require("which-key")

local function cprevious()
    vim.cmd("silent! " .. vim.v.count1 .. "cprevious")
    vim.cmd.normal("zv")
end

local function cnext()
    vim.cmd("silent! " .. vim.v.count1 .. "cnext")
    vim.cmd.normal("zv")
end

whichKey.add({
    { "[", group = "Previous" },
    { "]", group = "Next" },
    { "[q", desc = "Quickfix" },
    { "]q", desc = "Quickfix" },
})

local function map(lhs, rhs, desc)
    vim.keymap.set("n", lhs, rhs, { desc = desc })
end

map("[q", cprevious, "Previous quickfix entry")
map("]q", cnext, "Next quickfix entry")