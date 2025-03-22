local ufo = require("ufo")
local whichKey = require("which-key")

whichKey.add({
    { "zR", ufo.openAllFolds,         desc = "Open all folds", },
    { "zM", ufo.closeAllFolds,        desc = "Close all folds", },
    { "zr", ufo.openFoldsExceptKinds, desc = "Fold less", },
    { "zm", ufo.closeFoldsWith,       desc = "Fold more", },
})

vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        ufo.peekFoldedLinesUnderCursor()
    end,
})
