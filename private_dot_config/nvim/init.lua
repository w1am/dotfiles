require("config.lazy")
require("config.keymaps")

vim.o.number = true
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.clipboard = "unnamedplus"
vim.o.mouse = "a"
vim.o.swapfile = false

vim.opt.scrolloff = 8
vim.opt.undofile = true
vim.opt.belloff = "all"

vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true, silent = true })
vim.api.nvim_set_option('guicursor', 'n:block-Cursor,i:block-Cursor,v:block-Cursor')

vim.cmd('syntax on')

vim.o.background = 'dark'
