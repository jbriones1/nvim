local g = vim.g
function map(mode, alias, curr)
	vim.keymap.set(mode, alias, curr, { silent = true })
end

g.mapleader = ' '

map('n', ';', ':')
map('n', '<leader>pv', vim.cmd.Ex)
