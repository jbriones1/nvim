vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
require('nvim-tree').setup({
	view = {
		side = 'left',
		mappings = {
			list = {
				{ key = 'u', action ='dir_up' }
			},
		},
	}
})
map('n', '<C-b>', ':NvimTreeToggle<CR>')
