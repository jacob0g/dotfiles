return {
    {
        "mason-org/mason-lspconfig.nvim",

        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
        
        opts = {
            ensure_installed = {
                "lua_ls",
                "basedpyright",
                "vimls",
                "clangd",
            },
        },

        config = function(_, opts)
            vim.lsp.config("basedpyright", {
                settings = {
                    basedpyright = {
                    analysis = {
                        diagnosticMode = "workspace",
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true,
                    },
                },
            },
        })
        require("mason-lspconfig").setup(opts)
      end,
    },
}
