if vim.g.vscode then
  vim.api.nvim_set_keymap('n', '<S-tab>', ':Tabprevious<CR>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<tab>', ':Tabnext<CR>', {noremap = true, silent = true})

  vim.api.nvim_set_keymap('i', 'jk', '<Esc>', {noremap = true})
else
  vim.api.nvim_set_keymap('i', 'jk', '<Esc>', {noremap = true, silent = true})

  vim.wo.number = true
  vim.o.clipboard = "unnamedplus"

  vim.o.tabstop = 2
  vim.o.shiftwidth = 2
  vim.o.expandtab = true
end


