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
            auto_start = 'shut-up',
            display = {
                pum = {
                    y_max_len = 5, -- max length of preview
                },
            },
            keymap = {
                recommended = false,
                jump_to_mark = "",
            },
        }
    end,

    config = function()
        -- LSP Settings
    end,
}
