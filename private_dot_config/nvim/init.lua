require("config.lazy")
require("config.keymaps")

vim.o.number = true            -- show line numbers
vim.o.expandtab = true         -- use spaces instead of tabs
vim.o.shiftwidth = 4           -- shift 4 spaces when indenting
vim.o.tabstop = 4              -- a tab is 4 spaces
vim.o.clipboard = "unnamedplus"-- use system clipboard
vim.o.mouse = "a"              -- enable mouse
vim.o.swapfile = false         -- disable swapfile

vim.opt.scrolloff = 8
vim.opt.undofile = true
vim.opt.belloff = "all"        -- no audible (or visual) bell

vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true, silent = true })
vim.api.nvim_set_option('guicursor', 'n:block-Cursor,i:block-Cursor,v:block-Cursor')

vim.cmd('syntax on')

vim.o.background = 'dark'

