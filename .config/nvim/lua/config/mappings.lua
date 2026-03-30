local map = vim.keymap.set

-- General Mappings
map('n', "<C-s>", "<cmd> w <CR>")

-- Telescope
local ts = require("telescope.builtin")
map('n', "<leader>ff", ts.find_files, { desc = "Telescope find files" })
map('n', "<leader>fg", ts.live_grep, { desc = "Telescope live grep" })
map('n', "<leader>fb", ts.buffers, { desc = "Telescope buffers" })
map('n', "<leader>fh", ts.help_tags, { desc = "Telescope help tags" })

map('n', "<leader>fr", ts.lsp_references, { desc = "Telescope LSP references" })
map('n', "<leader>fd", ts.lsp_definitions, { desc = "Telescope LSP definition" })

-- Window
-- -- Navigation
map('n', "<C-h>", "<C-w>h", { noremap = true })
map('n', "<C-j>", "<C-w>j", { noremap = true })
map('n', "<C-k>", "<C-w>k", { noremap = true })
map('n', "<C-l>", "<C-w>l", { noremap = true })
-- -- Resizing
-- map('n', "<C-Up>", ":resize -2<CR>")
-- map('n', "<C-Left>", ":vertical resize -2<CR>")


-- Buffer Tabs
local opts = { noremap = true, silent = true }
    -- Move to previous/next
map('n', "<Tab>", "<cmd> BufferNext <CR>", opts)
map('n', "<S-Tab>", "<cmd> BufferPrev <CR>", opts)
    -- Close current tab
map('n', "<C-q>", "<cmd> BufferClose <CR>", opts)

-- comment.nvim
map('n', "<leader>/", "gcc", { remap = true })
map('v', "<leader>/", "gc", { remap = true })

-- nvim-tree
map('n', "<leader>n", "<cmd> NvimTreeToggle <CR>", opts)

-- Expand LSP errors
map('n', "<leader>e",
    function() vim.diagnostic.open_float() end,
    { desc = "Expand Error" }
)

-- coq_nvim:
coq_opts = { expr = true, silent = true, noremap = true }

-- coq_nvim: Arrow keys close preview window
vim.api.nvim_set_keymap('i', "<Up>", [[pumvisible() ? "\<C-e><Up>" : "\<Up>"]], coq_opts)
vim.api.nvim_set_keymap('i', "<Down>", [[pumvisible() ? "\<C-e><Down>" : "\<Down>"]], coq_opts)

-- coq_nvim: Preview navigation
vim.api.nvim_set_keymap('i', "<C-j>", [[pumvisible() ? "\<C-n>" : "\<C-j>"]], coq_opts)
vim.api.nvim_set_keymap('i', "<C-k>", [[pumvisible() ? "\<C-p>" : "\<C-k>"]], coq_opts)
vim.api.nvim_set_keymap('i', "<S-Tab>", [[pumvisible() ? (complete_info().selected == -1 ? "\<C-n><C-y>" : "\<C-y>") : "\<S-Tab>"]], coq_opts)
vim.api.nvim_set_keymap('i', "<CR>", [[pumvisible() ? "\<C-e><CR>" : "\<CR>"]], coq_opts)

-- coq_nvim: If preview open, don't leave insert mode on escape key
-- vim.api.nvim_set_keymap('i', "<ESC>", [[pumvisible() ? "\<C-e>" : "\<ESC>"]], coq_opts)

