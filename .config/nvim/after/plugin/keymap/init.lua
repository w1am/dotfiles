local Remap = require("w1am.keymap")
local nnoremap = Remap.nnoremap
local nmap = Remap.nmap

local default_opts = {noremap = true, silent = true}

nnoremap("<leader>f", ":Ex<CR>")

nmap('<leader>l', ':nohlsearch<CR><C-L>', default_opts)

