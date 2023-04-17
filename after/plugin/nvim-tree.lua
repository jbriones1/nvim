vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
require('nvim-tree').setup({
    view = {
        side = 'right',
        width = 70,
        mappings = {
            list = {
                { key = 'u', action = 'dir_up' }
            },
        },
    },
    git = {
        enable = true,
        ignore = false,
        timeout = 1000,
    },
    update_focused_file = {
        enable = true
    },
    diagnostics = {
        enable = true
    },
    filters = {
        dotfiles = true,
        exclude = { '.build' }
    }
})
map('n', '<C-b>', ':NvimTreeToggle<CR>')
