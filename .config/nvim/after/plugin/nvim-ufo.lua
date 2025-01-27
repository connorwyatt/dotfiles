local ufo = require("ufo")
local whichKey = require("which-key")

whichKey.add({
    { "zR", ufo.openAllFolds,  desc = "Open all folds", },
    { "zM", ufo.closeAllFolds, desc = "Close all folds", },
})
