local git_conflict = require('git-conflict')

git_conflict.setup({
    default_mappings = true,     -- disable buffer local mapping created by this plugin
    default_commands = true,     -- disable commands created by this plugin
    disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
    highlights = {
        -- They must have background color, otherwise the default color will be used
        incoming = 'DiffText',
        current = 'DiffAdd',
    }
}
)
vim.keymap.set('n', '<leader>gct', '<Plug>(git-conflict-theirs)', { desc = 'Resolve conflict theirs' })
vim.keymap.set('n', '<leader>gco', '<Plug>(git-conflict-ours)', { desc = 'Resolve conflict ours' })
vim.keymap.set('n', '<leader>gcb', '<Plug>(git-conflict-both)', { desc = 'Resolve conflict both' })
vim.keymap.set('n', '<leader>gcn', '<Plug>(git-conflict-none)', { desc = 'Resolve conflict none' })
vim.keymap.set('n', ']x', '<Plug>(git-conflict-prev-conflict)', { desc = 'Previous conflict' })
vim.keymap.set('n', '[x', '<Plug>(git-conflict-next-conflict)', { desc = 'Next conflict' })
