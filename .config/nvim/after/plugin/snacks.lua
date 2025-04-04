local whichKey = require("which-key")

whichKey.add({
    {
        "[w",
        function()
            Snacks.words.jump(-1)
        end,
        desc = "Previous word occurrence",
    },
    {
        "]w",
        function()
            Snacks.words.jump(1)
        end,
        desc = "Next word occurrence",
    },
})
