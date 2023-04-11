vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
require('nvim-tree').setup({
    view = {
        side = 'left',
        width = 50,
        mappings = {
            list = {
                { key = 'u', action ='dir_up' }
            },
        },
    },
    update_focused_file = {
        enable = true
    }
})
map('n', '<C-b>', ':NvimTreeToggle<CR>')
