local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}
local cmd = vim.cmd

map('n', '<leader>l', ':nohlsearch<CR><C-L>', default_opts)
map('i', 'jk', '<Esc>', {noremap = true})

map('', '<up>', '<nop>', {noremap = true})
map('', '<down>', '<nop>', {noremap = true})
map('', '<left>', '<nop>', {noremap = true})
map('', '<right>', '<nop>', {noremap = true})

map('n', '<C-n>', ':NvimTreeToggle<CR>', default_opts)
map('n', '<leader>r', ':NvimTreeRefresh<CR>', default_opts)
map('n', '<leader>n', ':NvimTreeFindFile<CR>', default_opts)

map('n', '<C-h>', '<C-w>h', default_opts)
map('n', '<C-j>', '<C-w>j', default_opts)
map('n', '<C-k>', '<C-w>k', default_opts)
map('n', '<C-l>', '<C-w>l', default_opts)

map('n', '<C-p>', "<cmd>lua require('telescope.builtin').find_files({ hidden = true })<cr>", {noremap=true})
map('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<cr>", {noremap=true})

map('n', '<S-TAB>', ":bnext<CR>", {noremap=true})
map('n', '<TAB>', ":bprevious<CR>", {noremap=true})

-- code actions
map('n', '<leader>ca', ":Lspsaga code_action<CR>", {noremap=true, silent=true})
map('v', '<leader>ca', ":<C-U>Lspsaga range_code_action<CR>", {noremap=true, silent=true})

-- definition
map('n', '<S-K>', ":Lspsaga hover_doc<CR>", {noremap=true, silent=true})

-- scroll down hover doc or scroll in definition preview
map('n', '<C-f>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", {noremap=true, silent=true})

-- scroll up ohover doc
map('n', '<C-b>', "<C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", {noremap=true, silent=true})

-- Lua
map("n", "<leader>xx", "<cmd>Trouble<cr>", {silent = true, noremap = true})
map("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>", {silent = true, noremap = true})
map("n", "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<cr>", {silent = true, noremap = true})
map("n", "<leader>xl", "<cmd>Trouble loclist<cr>", {silent = true, noremap = true})
map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", {silent = true, noremap = true})
map("n", "gR", "<cmd>Trouble lsp_references<cr>", {silent = true, noremap = true})

map("n", "[", ":cprev<CR>", {silent = true, noremap = true})
map("n", "]", ":cnext<CR>", {silent = true, noremap = true})
map("n", "<leader>ew", ":copen<CR>", {silent = true, noremap = true})
map("n", "<leader>q", ":ccl<CR>", {silent = true, noremap = true})

vim.cmd [[command! ReplaceAll lua require'plugins/replaceAll'.ReplaceAll()]]
