-- {{ Functions }}
local g = vim.g
local o = vim.opt
local a = vim.api

function map(mode, alias, curr)
	vim.keymap.set(mode, alias, curr, { silent = true })
end

-- {{ Config }}
g.mapleader = ' '
g.maplocalleader = ' '

o.relativenumber = true
o.tabstop = 4
o.shiftwidth = 4
o.autoindent = true
o.history = 50                         -- Remember 50 items in commandline history
o.updatetime = 200                     -- Decrease update time
o.signcolumn = 'yes'                   -- Always show sign column

-- Trailing spaces
o.list = true
o.listchars = 'trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂,space:·'

-- Buffer splitting
o.splitright = true
o.splitbelow = true

-- Case insensitive searching unless /C or capital in search
o.ignorecase = true
o.smartcase = true                     

-- Highlight region on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

-- {{ Keybinds }}
map('n', ';' , ':')
map('n', ',', '@q')
map('n', '<Enter>', 'o<Esc>')
map('n', '<C-m>', '<C-p>')                       -- Move to previous auto-complete
map('n', '<S-Enter', 'O<Esc>')

-- Moving windows
map('n', '<C-h>', '<C-W><C-H>')
map('n', '<C-j>', '<C-W><C-J>')
map('n', '<C-k>', '<C-W><C-K>')
map('n', '<C-l>', '<C-W><C-L>')
