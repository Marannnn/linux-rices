require("maran.remap")
require("maran.lazy")

--Line number
vim.wo.relativenumber = true

--OS clipboard
vim.opt.clipboard = "unnamedplus"

vim.opt["tabstop"] = 4
vim.opt["shiftwidth"] = 4


-- Pro Lua konfiguraci
vim.g.neovide_padding_top = 0
vim.g.neovide_padding_bottom = 0
vim.g.neovide_padding_left = 0
vim.g.neovide_padding_right = 0

-- Background
vim.cmd [[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
  highlight LineNr guibg=none ctermbg=none
]]
