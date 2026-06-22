return {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
        { "ms-jpq/coq_nvim", branch="coq" },

        -- 9000+ snippets
        { "ms-jpq/coq.artifacts", branch="artifacts" },

        { "ms-jpq/coq.thirdparty", branch="3p" },
    },

    init = function()
        -- COQ Settings
        vim.g.coq_settings = {
            keymap = {
                recommended = false,
            },
        }
        vim.o.pumheight = 5
    end,

    config = function()
        -- LSP Settings
    end,
}
