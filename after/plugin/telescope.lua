local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

telescope.setup {
    defaults = {
        sorting_strategy = 'ascending',
        layout_config = {
            horizontal = {
                prompt_position = 'top',
            }
        },
        path_display = function(opts, path)
            local tail = require('telescope.utils').path_tail(path)
            return string.format('%s (%s)', tail, path)
        end,
        mappings = {
            i = {
                ['<Esc>'] = actions.close,
                -- ['<C-o>'] = actions.select_default + builtin.resume,
                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous,
            }
        }
    },
    extension = {
        ['ui-select'] = {
            require('telescope.themes').get_dropdown {}
        }
    }
}

telescope.load_extension('ui-select')

vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Find files (non-git)' })
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<C-f>', builtin.live_grep, {})
vim.keymap.set('n', '<C-g>', builtin.resume, { desc = 'Open previous telescope window' })
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input('Grep > ') })
end)
vim.keymap.set('n', '<leader>o', builtin.lsp_document_symbols, {})
-- h: hidden
-- a: active
-- %: focused
-- #: previous buffer
-- +: changed
vim.keymap.set('n', '<leader>b', function()
    builtin.buffers({ only_cwd = true })
end)
vim.keymap.set('n', '<leader>gf', builtin.git_bcommits, { desc = 'Git file history' })
vim.keymap.set('n', '<leader>pvf', builtin.oldfiles, { desc = 'Previous files' })
