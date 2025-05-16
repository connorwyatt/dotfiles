local heirline = require("heirline")
local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local highlights = {
    statusline = "StatusLine",
    statusline_nc = "StatusLineNC",
    section_a = "StatusLineSectionA",
    section_a_nc = "StatusLineSectionANC",
    section_b = "StatusLineSectionB",
    section_b_nc = "StatusLineSectionBNC",
    divider = "StatusLineDivider",
    modes = {
        normal = "StatusLineModeNormal",
        insert = "StatusLineModeInsert",
        visual = "StatusLineModeVisual",
        command = "StatusLineModeCommand",
        select = "StatusLineModeSelect",
        replace = "StatusLineModeReplace",
        prompt = "StatusLineModePrompt",
        terminal = "StatusLineModeTerminal",
    },
    modes_subtle = {
        normal = "StatusLineModeNormalSubtle",
        insert = "StatusLineModeInsertSubtle",
        visual = "StatusLineModeVisualSubtle",
        command = "StatusLineModeCommandSubtle",
        select = "StatusLineModeSelectSubtle",
        replace = "StatusLineModeReplaceSubtle",
        prompt = "StatusLineModePromptSubtle",
        terminal = "StatusLineModeTerminalSubtle",
    },
    modes_text = {
        normal = "StatusLineModeNormalText",
        insert = "StatusLineModeInsertText",
        visual = "StatusLineModeVisualText",
        command = "StatusLineModeCommandText",
        select = "StatusLineModeSelectText",
        replace = "StatusLineModeReplaceText",
        prompt = "StatusLineModePromptText",
        terminal = "StatusLineModeTerminalText",
    },
    file = {
        directory = "StatusLineFileDirectory",
        directory_modified = "StatusLineFileDirectoryModified",
        directory_icon = "Directory",
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
    { provider = "│" },
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

local ModeSubtleHighlights = {
    static = {
        mode_highlight_groups = {
            n = highlights.modes_subtle.normal,
            i = highlights.modes_subtle.insert,
            v = highlights.modes_subtle.visual,
            V = highlights.modes_subtle.visual,
            ["\22"] = highlights.modes_subtle.visual,
            c = highlights.modes_subtle.command,
            s = highlights.modes_subtle.select,
            S = highlights.modes_subtle.select,
            ["\19"] = highlights.modes_subtle.select,
            R = highlights.modes_subtle.replace,
            r = highlights.modes_subtle.prompt,
            ["!"] = highlights.modes_subtle.command,
            t = highlights.modes_subtle.terminal,
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
            return highlights.section_a_nc
        end
    end,
}

local SectionBHighlights = {
    hl = function()
        if conditions.is_active() then
            return highlights.section_b
        else
            return highlights.section_b_nc
        end
    end,
}

local NeovimLogo = {
    provider = "",
}

local VimMode = {
    static = {
        mode_names = {
            n = "Normal",
            no = "Normal",
            nov = "Normal",
            noV = "Normal",
            ["no\22"] = "Normal",
            niI = "Normal",
            niR = "Normal",
            niV = "Normal",
            nt = "Normal",
            v = "Visual",
            vs = "Visual",
            V = "Visual-Line",
            Vs = "Visual-Line",
            ["\22"] = "Visual-Block",
            ["\22s"] = "Visual-Block",
            s = "Select",
            S = "Select-Line",
            ["\19"] = "Select-Block",
            i = "Insert",
            ic = "Insert",
            ix = "Insert",
            R = "Replace",
            Rc = "Replace",
            Rx = "Replace",
            Rv = "Replace",
            Rvc = "Replace",
            Rvx = "Replace",
            c = "Command",
            cv = "Command",
            r = "Prompt",
            rm = "Prompt",
            ["r?"] = "Prompt",
            ["!"] = "Command",
            t = "Terminal",
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
        local mode_name = self.mode_names[self.mode]
        return mode_name and string.upper(mode_name)
    end,
}

local FileModifiedIndicator = {
    condition = function()
        return vim.bo.modified
    end,
    hl = highlights.file.modified,
    provider = "*",
}

local Cwd = {
    init = function(self)
        self.cwd = vim.fn.getcwd()
    end,
    { provider = "󰉋", hl = highlights.file.directory_icon },
    Spacer,
    {
        hl = highlights.file.basename,
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
    },
}

local OilCwd = {
    init = function(self)
        local oil_prefix = "oil://"
        local filename = vim.api.nvim_buf_get_name(0)
        self.cwd = filename:sub(#oil_prefix + 1, -2)
    end,
    { provider = "󰉋", hl = highlights.file.directory_icon },
    Spacer,
    {
        hl = function()
            if vim.bo.modified then
                return highlights.file.basename_modified
            else
                return highlights.file.basename
            end
        end,
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
    },
    FileModifiedIndicator,
}

local FileInfoProvider = {
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
        self.directory = vim.fn.fnamemodify(self.filename, ":.:h")
        self.base_name = vim.fn.fnamemodify(self.filename, ":t")
        local extension = vim.fn.fnamemodify(self.filename, ":e")
        self.icon, self.icon_color =
            require("nvim-web-devicons").get_icon_color(self.filename, extension, { default = true })
    end,
}

local FileName = utils.insert(FileInfoProvider, {
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
    FileModifiedIndicator,
    {
        condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
        end,
        hl = highlights.file.readonly,
        provider = " 󰌾",
    },
})

local FilePath = utils.insert(FileInfoProvider, {
    {
        hl = function(self)
            return { fg = self.icon_color }
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
        hl = function()
            if vim.bo.modified then
                return highlights.file.directory_modified
            else
                return highlights.file.directory
            end
        end,
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
    FileName,
})

local AutoformatIcon = {
    {
        provider = function()
            return "AF"
        end,
        hl = function()
            if vim.g.disable_autoformat then
                return highlights.autoformat.disabled
            else
                return highlights.autoformat.enabled
            end
        end,
    },
    {
        provider = function()
            return " "
        end,
        condition = function()
            return vim.b.disable_autoformat
        end,
        hl = function()
            if vim.b.disable_autoformat then
                return highlights.autoformat.disabled
            else
                return highlights.autoformat.enabled
            end
        end,
    },
}

local FileEncoding = {
    provider = function()
        return (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc
    end,
}

local FileFormat = {
    provider = function()
        return vim.bo.fileformat
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
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    end,
    {
        init = function(self)
            local children = {}

            if self.errors > 0 then
                table.insert(children, {
                    hl = highlights.diagnostics.error,
                    provider = "󰀨 " .. self.errors,
                })
            end

            if self.warnings > 0 then
                if #children > 0 then
                    table.insert(children, Spacer)
                end
                table.insert(children, {
                    hl = highlights.diagnostics.warning,
                    provider = "󰀦 " .. self.warnings,
                })
            end

            if self.info > 0 then
                if #children > 0 then
                    table.insert(children, Spacer)
                end
                table.insert(children, {
                    hl = highlights.diagnostics.info,
                    provider = "󰋼 " .. self.info,
                })
            end

            if self.hints > 0 then
                if #children > 0 then
                    table.insert(children, Spacer)
                end
                table.insert(children, {
                    hl = highlights.diagnostics.hint,
                    provider = "󰋗 " .. self.hints,
                })
            end

            self.children = self:new(children, 1)
        end,
        provider = function(self)
            return self.children:eval()
        end,
    },
}

local Git = {
    condition = conditions.is_git_repo,
    init = function(self)
        local status_dict = vim.b.gitsigns_status_dict
        self.head = status_dict.head
    end,
    {
        hl = highlights.git.branch,
        provider = function(self)
            return "󰊢 " .. self.head
        end,
    },
    {
        init = function(self)
            local status_dict = vim.b.gitsigns_status_dict
            local added = status_dict.added or 0
            local changed = status_dict.changed or 0
            local removed = status_dict.removed or 0

            local children = {}

            if added > 0 then
                table.insert(children, {
                    hl = highlights.git.added,
                    provider = "󰐖 " .. added,
                })
            end

            if changed > 0 then
                if #children > 0 then
                    table.insert(children, Spacer)
                end
                table.insert(children, {
                    hl = highlights.git.changed,
                    provider = "󰦓 " .. changed,
                })
            end

            if removed > 0 then
                if #children > 0 then
                    table.insert(children, Spacer)
                end
                table.insert(children, {
                    hl = highlights.git.removed,
                    provider = "󰍵 " .. removed,
                })
            end

            if #children > 0 then
                table.insert(children, 1, Spacer)
            end

            self.children = self:new(children, 1)
        end,
        provider = function(self)
            return self.children:eval()
        end,
    },
}

local Ruler = {
    provider = "%l:%c",
}

local DefaultStatusline = {
    utils.insert(ModeHighlights, Spacer, VimMode, Spacer),
    {
        condition = conditions.is_git_repo,
        Spacer,
    },
    Git,
    {
        condition = conditions.is_git_repo,
        Divider,
    },

    Align,
    FilePath,
    Align,

    {
        condition = conditions.has_diagnostics,
        Divider,
    },
    Diagnostics,
    Divider,
    AutoformatIcon,
    Divider,
    FileFormat,
    Divider,
    FileEncoding,
    {
        condition = function()
            return vim.bo.filetype ~= ""
        end,
        Divider,
        FileType,
    },
    Divider,
    Ruler,
    Spacer,
    utils.insert(ModeHighlights, Spacer),
}

local InactiveStatusline = {
    hl = highlights.statusline_nc,

    Align,
    FilePath,
    Align,
}

local EmptyStatusline = {
    Align,
}

local OilStatusline = {
    utils.insert(ModeHighlights, Spacer, VimMode, Spacer),
    {
        condition = conditions.is_git_repo,
        Spacer,
    },
    Git,
    {
        condition = conditions.is_git_repo,
        Divider,
    },

    Align,
    OilCwd,
    Align,

    utils.insert(ModeHighlights, Spacer),
}

local NeoTreeStatusline = {
    Git,
    {
        condition = conditions.is_git_repo,
        Divider,
    },

    Align,
    Cwd,
    Align,

    utils.insert(ModeHighlights, Spacer),
}

local Statusline = {
    fallthrough = false,

    {
        condition = function()
            return vim.bo.filetype == "neo-tree"
        end,
        NeoTreeStatusline,
    },
    {
        condition = function()
            return vim.bo.filetype == "oil"
        end,
        OilStatusline,
    },
    {
        condition = function()
            return vim.bo.buftype == "nofile" or vim.bo.buftype == "prompt"
        end,
        EmptyStatusline,
    },
    {
        condition = conditions.is_not_active,
        InactiveStatusline,
    },
    DefaultStatusline,
}

heirline.setup({
    statusline = Statusline,
})
