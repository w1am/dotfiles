local nnoremap = require("w1am.keymap").nnoremap
local nmap = require("w1am.keymap").nmap

local silent = { silent = true }

nnoremap("<leader>a", function() require("harpoon.mark").add_file() end, silent)
nnoremap("<C-w>", function() require("harpoon.ui").toggle_quick_menu() end, silent)

for i = 1, 5 do
  nmap(
    string.format("<space>%s", i), 
    function()
      require("harpoon.ui").nav_file(i)
    end,
    silent
  )
end
