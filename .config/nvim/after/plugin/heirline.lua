local heirline = require("heirline")
local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local Spacer = {
    provider = " ",
}

local Divider = {
    provider = " | ",
    hl = "StatusLineDivider",
}

local Align = {
    provider = "%=",
}

local ModeHighlights = {
    static = {
        mode_highlight_groups = {
            n = "StatusLineModeNormal",
            i = "StatusLineModeInsert",
            v = "StatusLineModeVisual",
            V = "StatusLineModeVisual",
            ["\22"] = "StatusLineModeVisual",
            c = "StatusLineModeCommand",
            s = "StatusLineModeSelect",
            S = "StatusLineModeSelect",
            ["\19"] = "StatusLineModeSelect",
            R = "StatusLineModeReplace",
            r = "StatusLineModePrompt",
            ["!"] = "StatusLineModeCommand",
            t = "StatusLineModeTerminal",
        },
    },
    init = function(self)
        self.mode = vim.fn.mode(1)
    end,
    hl = function(self)
        local mode = self.mode:sub(1, 1)
        return self.mode_highlight_groups[mode]
    end,
}

local Mode = utils.insert(ModeHighlights, {
    static = {
        mode_names = {
            n = "NORMAL",
            no = "NORMAL",
            nov = "NORMAL",
            noV = "NORMAL",
            ["no\22"] = "NORMAL",
            niI = "NORMAL",
            niR = "NORMAL",
            niV = "NORMAL",
            nt = "NORMAL",
            v = "VISUAL",
            vs = "VISUAL",
            V = "VISUAL-LINE",
            Vs = "VISUAL-LINE",
            ["\22"] = "VISUAL-BLOCK",
            ["\22s"] = "VISUAL-BLOCK",
            s = "SELECT",
            S = "SELECT-LINE",
            ["\19"] = "SELECT-BLOCK",
            i = "INSERT",
            ic = "INSERT",
            ix = "INSERT",
            R = "REPLACE",
            Rc = "REPLACE",
            Rx = "REPLACE",
            Rv = "REPLACE",
            Rvc = "REPLACE",
            Rvx = "REPLACE",
            c = "COMMAND",
            cv = "COMMAND",
            r = "PROMPT",
            rm = "PROMPT",
            ["r?"] = "PROMPT",
            ["!"] = "COMMAND",
            t = "TERMINAL",
        },
    },
    init = function(self)
        self.mode = vim.fn.mode(1)
    end,
    condition = conditions.is_active,
    provider = function(self)
        return " " .. self.mode_names[self.mode] .. " "
    end,
    update = {
        "BufEnter",
        "ModeChanged",
        pattern = "*:*",
        callback = vim.schedule_wrap(function()
            vim.cmd("redrawstatus")
        end),
    },
})

local FileName = {
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
        self.directory = vim.fn.fnamemodify(self.filename, ":.:h")
        self.base_name = vim.fn.fnamemodify(self.filename, ":t")
        local extension = vim.fn.fnamemodify(self.filename, ":e")
        self.icon, self.icon_color = require("nvim-web-devicons")
            .get_icon_color(self.filename, extension, { default = true })
        self.is_file_buffer = true
    end,
    hl = "StatusLineFileName",
    Spacer,
    {
        provider = function(self)
            return self.icon
        end,
        hl = function(self)
            return { fg = self.icon_color, }
        end
    },
    Spacer,
    {
        init = function(self)
            local directory = self.directory

            if self.base_name ~= "" then
                directory = directory .. "/"
            end

            self.directory_string = directory
        end,
        hl = "StatusLineFileDirectory",
        flexible = 10,
        {
            provider = function(self)
                return self.directory_string
            end,
        },
        {
            provider = function(self)
                return vim.fn.pathshorten(self.directory_string)
            end,
        },
        {
            provider = "",
        },
    },
    {
        provider = function(self)
            if self.base_name == "" and self.directory == "" then
                return "[No Name]"
            end

            return self.base_name
        end,
        hl = function(self)
            if self.is_file_buffer and vim.bo.modified then
                return "StatusLineFileBaseNameModified"
            else
                return "StatusLineFileBaseName"
            end
        end,
    },
    {
        condition = function(self)
            return self.is_file_buffer and vim.bo.modified
        end,
        provider = " ",
        hl = "StatusLineFileModified",
    },
    {
        condition = function(self)
            return self.is_file_buffer and (not vim.bo.modifiable or vim.bo.readonly)
        end,
        provider = " ",
        hl = "StatusLineFileReadonly",
    },
    Spacer,
    { provider = "%<" }
}

local FileEncoding = {
    hl = "StatusLineFileEncoding",
    Spacer,
    {
        provider = function()
            return ""
        end,
        hl = function()
            if vim.g.enable_autoformat then
                return "StatusLineAutoformatEnabled"
            else
                return "StatusLineAutoformatDisabled"
            end
        end,
    },
    Divider,
    {
        provider = function()
            return (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc
        end,
    },
    Spacer,
}

local Diagnostics = {
    condition = conditions.has_diagnostics,
    init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR, })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN, })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT, })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO, })
    end,
    hl = "StatusLineDiagnostic",
    Spacer,
    {
        provider = function(self)
            return self.errors > 0 and (" " .. self.errors)
        end,
        hl = "StatusLineDiagnosticError",
    },
    {
        provider = function(self)
            return self.warnings > 0 and ("  " .. self.warnings)
        end,
        hl = "StatusLineDiagnosticWarning",
    },
    {
        provider = function(self)
            return self.info > 0 and ("  " .. self.info)
        end,
        hl = "StatusLineDiagnosticInfo",
    },
    {
        provider = function(self)
            return self.hints > 0 and ("  " .. self.hints)
        end,
        hl = "StatusLineDiagnosticHint",
    },
    Spacer,
}

local Git = {
    condition = conditions.is_git_repo,
    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
    end,
    hl = "StatusLineGit",
    {
        provider = function(self)
            return "  " .. self.status_dict.head
        end,
        hl = "StatusLineGitBranch",
    },
    {
        provider = function(self)
            local count = self.status_dict.added or 0
            return count > 0 and ("  " .. count)
        end,
        hl = "StatusLineGitAdded",
    },
    {
        provider = function(self)
            local count = self.status_dict.changed or 0
            return count > 0 and ("  " .. count)
        end,
        hl = "StatusLineGitChanged",
    },
    {
        provider = function(self)
            local count = self.status_dict.removed or 0
            return count > 0 and ("  " .. count)
        end,
        hl = "StatusLineGitRemoved",
    },
}

local Ruler = {
    condition = conditions.is_active,
    utils.insert(ModeHighlights, {
        provider = " %l:%c ",
    })
}

local Statusline = {
    Mode,
    FileName,
    Git,

    Align,

    Diagnostics,
    FileEncoding,
    Ruler,
}

heirline.setup({
    statusline = Statusline,
})
