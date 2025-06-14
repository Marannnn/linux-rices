vim.g.mapleader =" "
vim.g.maplocalleader = "\\"
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

--tabs
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<cr>", {desc = "Open new tab"})
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<cr>", {desc = "Close current tab"})
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<cr>", {desc = "Switch to next tab"})
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<cr>", {desc = "Switch to previous tab"})
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<cr>", {desc = "Open current buffer in new tab"})


-- TELESCOPE
vim.keymap.set('n', '<leader>ff', "<cmd>Telescope find_files<cr>", {desc = 'Fuzzy find files in cwd' })
vim.keymap.set('n', '<leader>fr', "<cmd>Telescope oldfiles<cr>", { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fg', "<cmd>Telescope live_grep<cr>", { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fc', "<cmd>Telescope grep_string<cr>",  { desc = 'Find string under cursor' })

--[[

--LSP mason
cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    })
==]]
--vim.keymap.set('i', '<C-b>', cmp.mapping.scroll_docs(-4))

