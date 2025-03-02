local whichKey = require("which-key")

whichKey.add({
    { "<leader>s",  group = "Search", },
    { "<leader>s'", function() Snacks.picker.marks() end,                 desc = "Marks" },
    { "<leader>s/", function() Snacks.picker.grep() end,                  desc = "Grep" },
    { "<leader>sC", function() Snacks.picker.command_history() end,       desc = "Command history" },
    { "<leader>sH", function() Snacks.picker.highlights() end,            desc = "Highlights" },
    { "<leader>sP", function() Snacks.picker.projects() end,              desc = "Projects" },
    { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP workspace symbols" },
    { "<leader>sb", function() Snacks.picker.buffers() end,               desc = "Buffers" },
    { "<leader>sc", function() Snacks.picker.commands() end,              desc = "Commands" },
    { "<leader>sf", function() Snacks.picker.files() end,                 desc = "Find files" },
    { "<leader>sg", function() Snacks.picker.git_files() end,             desc = "Find git files" },
    { "<leader>sh", function() Snacks.picker.help() end,                  desc = "Help pages" },
    { "<leader>si", function() Snacks.picker.icons() end,                 desc = "Icons" },
    { "<leader>sl", function() Snacks.picker.resume() end,                desc = "Last search" },
    { "<leader>sp", function() Snacks.picker.lazy() end,                  desc = "Plugin" },
    { "<leader>sr", function() Snacks.picker.recent() end,                desc = "Recent" },
    { "<leader>ss", function() Snacks.picker.lsp_symbols() end,           desc = "LSP symbols" },
    { "<leader>sw", function() Snacks.picker.grep_word() end,             desc = "Visual selection or word", mode = { "n", "x" } },
    { '<leader>s"', function() Snacks.picker.registers() end,             desc = "Registers" },
})

local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local value = ev.data.params
            .value
        if not client or type(value) ~= "table" then
            return
        end
        local p = progress[client.id]

        for i = 1, #p + 1 do
            if i == #p + 1 or p[i].token == ev.data.params.token then
                p[i] = {
                    token = ev.data.params.token,
                    msg = ("[%3d%%] %s%s"):format(
                        value.kind == "end" and 100 or value.percentage or 100,
                        value.title or "",
                        value.message and (" **%s**"):format(value.message) or ""
                    ),
                    done = value.kind == "end",
                }
                break
            end
        end

        local msg = {}
        progress[client.id] = vim.tbl_filter(function(v)
            return table.insert(msg, v.msg) or not v.done
        end, p)

        local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
        vim.notify(table.concat(msg, "\n"), "info", {
            id = "lsp_progress",
            title = client.name,
            opts = function(notif)
                notif.icon = #progress[client.id] == 0 and " "
                    or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
        })
    end,
})
