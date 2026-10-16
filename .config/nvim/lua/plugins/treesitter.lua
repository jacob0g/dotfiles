return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = { 'neovim-treesitter/treesitter-parser-registry' },
        branch = "main",
        lazy = false,
        build = ":TSUpdate",

        indent = { enable = false },
        highlight = { enable = true },
        folds = { enable = false },

        ensure_installed = {
            "c",
            "python",
            "markdown",
            "bash",
            "lua",
            "yaml",
            "xml"
        }
    },
}

