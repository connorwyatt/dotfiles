local dap = require("dap")
local dapui = require("dapui")
local whichKey = require("which-key")

whichKey.add({
    { "<leader>d", group = "Debugging" },
    {
        "<leader>dn",
        function()
            dap.continue({ new = true })
        end,
        desc = "New session",
    },
    {
        "<leader>dc",
        function()
            dap.continue({ new = false })
        end,
        desc = "Continue session",
    },
    {
        "<leader>dr",
        function()
            dap.restart()
        end,
        desc = "Restart session",
    },
    {
        "<leader>db",
        function()
            dap.toggle_breakpoint()
        end,
        desc = "Toggle breakpoint",
    },
    {
        "<leader>dp",
        function()
            dap.pause()
        end,
        desc = "Pause session",
    },
    {
        "<leader>dt",
        function()
            dap.terminate()
        end,
        desc = "Terminate session",
    },
    {
        "<leader>dl",
        function()
            dap.list_breakpoints(true)
        end,
        desc = "List breakpoints",
    },
    { "<leader>du", group = "UI" },
    {
        "<leader>duo",
        function()
            dapui.open({ reset = true })
        end,
        desc = "Open UI",
    },
    {
        "<leader>duc",
        function()
            dapui.close()
        end,
        desc = "Close UI",
    },
})

dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end

dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end

dap.listeners.after.attach.debug_keybinds = function()
    vim.keymap.set("n", "<C-Left>", function()
        dap.step_back()
    end, { noremap = true, silent = true })
    vim.keymap.set("n", "<C-Right>", function()
        dap.step_over()
    end, { noremap = true, silent = true })
    vim.keymap.set("n", "<C-Down>", function()
        dap.step_into()
    end, { noremap = true, silent = true })
    vim.keymap.set("n", "<C-Up>", function()
        dap.step_out()
    end, { noremap = true, silent = true })
end

dap.listeners.after.launch.debug_keybinds = function()
    vim.keymap.set("n", "<C-Left>", function()
        dap.step_back()
    end, { noremap = true, silent = true })
    vim.keymap.set("n", "<C-Right>", function()
        dap.step_over()
    end, { noremap = true, silent = true })
    vim.keymap.set("n", "<C-Down>", function()
        dap.step_into()
    end, { noremap = true, silent = true })
    vim.keymap.set("n", "<C-Up>", function()
        dap.step_out()
    end, { noremap = true, silent = true })
end

dap.listeners.after.terminate.debug_keybinds = function()
    vim.keymap.del("n", "<C-Left>")
    vim.keymap.del("n", "<C-Right>")
    vim.keymap.del("n", "<C-Down>")
    vim.keymap.del("n", "<C-Up>")
end

dap.listeners.after.exited.debug_keybinds = function()
    vim.keymap.del("n", "<C-Left>")
    vim.keymap.del("n", "<C-Right>")
    vim.keymap.del("n", "<C-Down>")
    vim.keymap.del("n", "<C-Up>")
end
