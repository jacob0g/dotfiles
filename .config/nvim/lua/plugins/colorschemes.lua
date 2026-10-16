return {
    {
        "nyoom-engineering/oxocarbon.nvim",
        build = false,
        lazy = false,
        config = function()
            vim.cmd([[colorscheme oxocarbon]])
        end,
        priority=1000,
    },
    {
        "olimorris/onedarkpro.nvim",
        priority=1000,
    }
}
