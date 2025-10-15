-- nvim root config

-- options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.undofile = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.modeline = false
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0

vim.opt.termguicolors = true
vim.g.have_nerd_font = true

vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- plugin manager
require("config.lazy")

-- mappings
require("config.mappings")

-- colorscheme
vim.cmd("colorscheme onedark")

vim.keymap.set("n", "<leader>[", "<cmd> colorscheme onedark <CR>")
vim.keymap.set("n", "<leader>]", "<cmd> colorscheme onedark_dark <CR>")
