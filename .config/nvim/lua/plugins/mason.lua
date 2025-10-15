return {
    {
        "mason-org/mason-lspconfig.nvim",
        
        opts = {
            ensure_installed = {
                "lua_ls",
                "pyright",
                "vimls",
                "clangd",
            },
        },

        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
    },
}
