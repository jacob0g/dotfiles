local function tree_on_attach(bufnr)
    local api = require("nvim-tree.api")

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set('n', "<leader>n",    api.tree.toggle)
    vim.keymap.set('n', "<leader>|",    api.node.open.vertical)
    vim.keymap.set('n', "<leader>-",    api.node.open.horizontal)
    
end

return {
    {
        "nvim-tree/nvim-tree.lua",
        -- lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        
        config = function()
            require("nvim-tree").setup {
                on_attach = tree_on_attach,
            }
        end,
        version="^1.0",
    },
}
