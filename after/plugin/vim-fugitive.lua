vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = 'Git status' })
vim.keymap.set("n", "<leader>gf", ':0Gclog<CR>', { desc = 'Git file history' })
vim.keymap.set("n", "<leader>gD", ':Gvdiffsplit!<CR>', { desc = 'Merge tool' })
vim.keymap.set("n", "<leader>gW", ':Gwrite<CR>', { desc = 'Commit afte merging' })
