local cmd = vim.cmd
local exec = vim.api.nvim_exec
local fn = vim.fn
local g = vim.g
local opt = vim.opt

g.mapleader = ' '
opt.mouse = 'a'
opt.clipboard = 'unnamedplus'
opt.swapfile = false

opt.number = true
opt.showmatch = true
opt.foldmethod = 'manual'
opt.foldexpr = ""
opt.splitright = true
opt.splitbelow = true
opt.ignorecase = true
opt.smartcase = true
opt.linebreak = true
opt.undofile = true
opt.updatetime = 300
opt.signcolumn = "yes"

cmd [[au BufWritePre * :%s/\s\+$//e]]

opt.termguicolors = true
-- cmd [[colorscheme tokyonight]]

g.tokyonight_style = "night"
g.tokyonight_italic_functions = true
g.tokyonight_colors = { hint = "orange", error = "#ff0000" }

g.molokai_original = 1
g.tmux_navigator_no_mappings = 1

opt.hidden = false
opt.history = 100
opt.lazyredraw = true
opt.synmaxcol = 240

opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true
