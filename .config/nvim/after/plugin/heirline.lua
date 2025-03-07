local heirline = require("heirline")
local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local highlights = {
    statusline = "StatusLine",
    statusline_inactive = "StatusLineInactive",
    section_a = "StatusLineSectionA",
    section_a_inactive = "StatusLineSectionAInactive",
    section_b = "StatusLineSectionB",
    section_b_inactive = "StatusLineSectionBInactive",
    divider = "StatusLineDivider",
    modes = {
        normal   = "StatusLineModeNormal",
        insert   = "StatusLineModeInsert",
        visual   = "StatusLineModeVisual",
        command  = "StatusLineModeCommand",
        select   = "StatusLineModeSelect",
        replace  = "StatusLineModeReplace",
        prompt   = "StatusLineModePrompt",
        terminal = "StatusLineModeTerminal",
    },
    modes_text = {
        normal   = "StatusLineModeNormalText",
        insert   = "StatusLineModeInsertText",
        visual   = "StatusLineModeVisualText",
        command  = "StatusLineModeCommandText",
        select   = "StatusLineModeSelectText",
        replace  = "StatusLineModeReplaceText",
        prompt   = "StatusLineModePromptText",
        terminal = "StatusLineModeTerminalText",
    },
    cwd = "StatusLineCwd",
    file = {
        directory = "StatusLineFileDirectory",
        basename = "StatusLineFileBaseName",
        basename_modified = "StatusLineFileBaseNameModified",
        modified = "StatusLineFileModified",
        readonly = "StatusLineFileReadonly",
    },
    autoformat = {
        enabled = "StatusLineAutoformatEnabled",
        disabled = "StatusLineAutoformatDisabled",
    },
    diagnostics = {
        error = "StatusLineDiagnosticError",
        warning = "StatusLineDiagnosticWarning",
        info = "StatusLineDiagnosticInfo",
        hint = "StatusLineDiagnosticHint",
    },
    git = {
        branch = "StatusLineGitBranch",
        added = "StatusLineGitAdded",
        changed = "StatusLineGitChanged",
        removed = "StatusLineGitRemoved",
    },
}

local Spacer = {
    provider = " ",
}

local Divider = {
    hl = highlights.divider,
    Spacer,
    { provider = "|", },
    Spacer,
}

local Align = {
    provider = "%=",
}

local ModeHighlights = {
    static = {
        mode_highlight_groups = {
            n = highlights.modes.normal,
            i = highlights.modes.insert,
            v = highlights.modes.visual,
            V = highlights.modes.visual,
            ["\22"] = highlights.modes.visual,
            c = highlights.modes.command,
            s = highlights.modes.select,
            S = highlights.modes.select,
            ["\19"] = highlights.modes.select,
            R = highlights.modes.replace,
            r = highlights.modes.prompt,
            ["!"] = highlights.modes.command,
            t = highlights.modes.terminal,
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

local ModeTextHighlights = {
    static = {
        mode_highlight_groups = {
            n = highlights.modes_text.normal,
            i = highlights.modes_text.insert,
            v = highlights.modes_text.visual,
            V = highlights.modes_text.visual,
            ["\22"] = highlights.modes_text.visual,
            c = highlights.modes_text.command,
            s = highlights.modes_text.select,
            S = highlights.modes_text.select,
            ["\19"] = highlights.modes_text.select,
            R = highlights.modes_text.replace,
            r = highlights.modes_text.prompt,
            ["!"] = highlights.modes_text.command,
            t = highlights.modes_text.terminal,
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

local SectionAHighlights = {
    hl = function()
        if conditions.is_active() then
            return highlights.section_a
        else
            return highlights.section_a_inactive
        end
    end,
}

local SectionBHighlights = {
    hl = function()
        if conditions.is_active() then
            return highlights.section_b
        else
            return highlights.section_b_inactive
        end
    end,
}

local NeovimLogo = {
    provider = ""
}

local VimMode = {
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
    update = {
        "BufEnter",
        "ModeChanged",
        pattern = "*:*",
        callback = vim.schedule_wrap(function()
            vim.cmd("redrawstatus")
        end),
    },
    provider = function(self)
        return self.mode_names[self.mode]
    end,
}

local Cwd = {
    init = function(self)
        self.cwd = vim.fn.getcwd()
    end,
    hl = highlights.cwd,
    flexible = 10,
    {
        provider = function(self)
            return self.cwd
        end,
    },
    {
        provider = function(self)
            return vim.fn.pathshorten(self.cwd)
        end,
    },
    {
        provider = "",
    },
}

local FileName = {
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
        self.directory = vim.fn.fnamemodify(self.filename, ":.:h")
        self.base_name = vim.fn.fnamemodify(self.filename, ":t")
        local extension = vim.fn.fnamemodify(self.filename, ":e")
        self.icon, self.icon_color = require("nvim-web-devicons")
            .get_icon_color(self.filename, extension, { default = true })
    end,
    {
        hl = function(self)
            return { fg = self.icon_color, }
        end,
        provider = function(self)
            return self.icon
        end,
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
        condition = function(self)
            return self.directory ~= "."
        end,
        hl = highlights.file.directory,
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
        hl = function()
            if vim.bo.modified then
                return highlights.file.basename_modified
            else
                return highlights.file.basename
            end
        end,
        provider = function(self)
            if self.base_name == "" and self.directory == "" then
                return "[No Name]"
            end

            return self.base_name
        end,
    },
    {
        condition = function()
            return vim.bo.modified
        end,
        hl = highlights.file.modified,
        provider = "*",
    },
    {
        condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
        end,
        hl = highlights.file.readonly,
        provider = " ",
    },
}

local AutoformatIcon = {
    provider = function()
        return ""
    end,
    hl = function()
        if vim.g.enable_autoformat then
            return highlights.autoformat.enabled
        else
            return highlights.autoformat.disabled
        end
    end,
}

local FileEncoding = {
    provider = function()
        return (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc
    end,
}

local BufType = {
    provider = function()
        return vim.bo.buftype
    end,
}

local FileType = {
    provider = function()
        return vim.bo.filetype
    end,
}

local Diagnostics = {
    condition = conditions.has_diagnostics,
    init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR, })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN, })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO, })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT, })
        self.errors_spacing = self.warnings > 0 or self.info > 0 or self.hints > 0
        self.warnings_spacing = self.info > 0 or self.hints > 0
        self.info_spacing = self.hints > 0
    end,
    {
        hl = highlights.diagnostics.error,
        provider = function(self)
            return self.errors > 0 and (" " .. self.errors)
        end,
    },
    {
        condition = function(self)
            return self.errors_spacing
        end,
        Spacer,
    },
    {
        hl = highlights.diagnostics.warning,
        provider = function(self)
            return self.warnings > 0 and (" " .. self.warnings)
        end,
    },
    {
        condition = function(self)
            return self.warnings_spacing
        end,
        Spacer,
    },
    {
        hl = highlights.diagnostics.info,
        provider = function(self)
            return self.info > 0 and (" " .. self.info)
        end,
    },
    {
        condition = function(self)
            return self.info_spacing
        end,
        Spacer,
    },
    {
        hl = highlights.diagnostics.hint,
        provider = function(self)
            return self.hints > 0 and (" " .. self.hints)
        end,
    },
}

local Git = {
    condition = conditions.is_git_repo,
    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
    end,
    {
        hl = highlights.git.branch,
        provider = function(self)
            return " " .. self.status_dict.head
        end,
    },
    {
        hl = highlights.git.added,
        provider = function(self)
            local count = self.status_dict.added or 0
            return count > 0 and ("  " .. count)
        end,
    },
    {
        hl = highlights.git.changed,
        provider = function(self)
            local count = self.status_dict.changed or 0
            return count > 0 and ("  " .. count)
        end,
    },
    {
        hl = highlights.git.removed,
        provider = function(self)
            local count = self.status_dict.removed or 0
            return count > 0 and ("  " .. count)
        end,
    },
}

local Ruler = {
    provider = "%l:%c",
}

local DefaultStatusline = {
    hl = highlights.statusline,
    utils.insert(ModeHighlights, Spacer, VimMode, Spacer),
    utils.insert(SectionBHighlights, Spacer, FileName, Spacer),
    Spacer,
    Git,

    Align,

    Diagnostics,
    Spacer,
    utils.insert(SectionBHighlights, Spacer, AutoformatIcon, Divider, FileEncoding, Spacer),
    utils.insert(SectionAHighlights, Spacer, Ruler, Spacer),
}

local InactiveStatusline = {
    condition = conditions.is_not_active,
    hl = highlights.statusline_inactive,
    utils.insert(SectionBHighlights, Spacer, FileName, Spacer),
    Spacer,
    Git,

    Align,

    Diagnostics,
    Spacer,
    utils.insert(SectionBHighlights, Spacer, FileEncoding, Spacer),
}

local EmptyStatusline = {
    condition = function()
        return vim.bo.buftype == "nofile" or vim.bo.buftype == "prompt"
    end,
    hl = highlights.statusline,
    Align,
}

local NeoTreeStatusline = {
    condition = function()
        return vim.bo.filetype == "neo-tree"
    end,
    hl = highlights.statusline,
    utils.insert(SectionBHighlights, Spacer, Cwd, Spacer),
    Spacer,
    Git,

    Align,
}

local Statusline = {
    fallthrough = false,

    NeoTreeStatusline,
    EmptyStatusline,
    InactiveStatusline,
    DefaultStatusline,
}

heirline.setup({
    statusline = Statusline,
})
