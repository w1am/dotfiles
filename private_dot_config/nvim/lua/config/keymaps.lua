local function copy_to_clipboard(text, label)
  vim.fn.setreg("+", text)
  vim.notify(label .. ": " .. text)
end

vim.keymap.set("n", "<leader>cp", function()
  copy_to_clipboard(vim.fn.expand("%:p"), "Full path")
end, { desc = "Copy full path" })

vim.keymap.set("n", "<leader>cr", function()
  copy_to_clipboard(vim.fn.expand("%"), "Relative path")
end, { desc = "Copy relative path" })

vim.keymap.set("n", "<leader>cf", function()
  copy_to_clipboard(vim.fn.expand("%:t"), "Filename")
end, { desc = "Copy filename" })

vim.keymap.set("n", "<leader>cd", function()
  copy_to_clipboard(vim.fn.expand("%:p:h"), "Directory")
end, { desc = "Copy directory path" })
