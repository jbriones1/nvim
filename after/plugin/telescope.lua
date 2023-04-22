local telescope = require('telescope')

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
        end
    },
    extension = {
        ['ui-select'] = {
            require('telescope.themes').get_dropdown {}
        }
    }
}

telescope.load_extension('ui-select')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<C-f>', builtin.live_grep, {})
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
vim.keymap.set('n', '<leader>pvf', builtin.oldfiles, {})
