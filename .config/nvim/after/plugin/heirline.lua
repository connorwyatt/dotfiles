local heirline = require("heirline")
local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local highlights = {
    statusline = "StatusLine",
    statusline_nc = "StatusLineNC",
    divider = "StatusLineDivider",
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

local FileModifiedIndicator = {
    condition = function()
        return vim.bo.modified
    end,
    hl = highlights.file.modified,
    provider = "[+]",
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
    FilePath,
    {
        condition = conditions.is_git_repo,
        Divider,
    },
    Git,

    Align,

    {
        condition = conditions.has_diagnostics,
        Divider,
    },
    Diagnostics,
    Divider,
    AutoformatIcon,
    Divider,
    Ruler,
}

local InactiveStatusline = {
    hl = highlights.statusline_nc,

    FilePath,

    Align,
}

local EmptyStatusline = {
    Align,
}

local NeoTreeStatusline = {
    Git,
    {
        condition = conditions.is_git_repo,
        Divider,
    },
    Cwd,

    Align,
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
