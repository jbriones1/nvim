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

-- Line numbers
o.relativenumber = true
o.number = true

-- Four space indent
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smartindent = true

o.autoindent = true
o.history = 50                         -- Remember 50 items in commandline history
o.updatetime = 200                     -- Decrease update time
o.signcolumn = 'yes'                   -- Always show sign column
o.scrolloff = 8
o.wrap = false
o.colorcolumn = '120'

-- Better searching
o.incsearch = true
o.hlsearch = false

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
map('n', '<S-Enter>', 'O<Esc>')
map('n', '<leader>v', '<C-v>')

-- Moving windows
map('n', '<C-h>', '<C-W><C-H>')
map('n', '<C-j>', '<C-W><C-J>')
map('n', '<C-k>', '<C-W><C-K>')
map('n', '<C-l>', '<C-W><C-L>')

-- Moving text while highlighted
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

-- Append next line to end without moving cursor
map('n', 'J', 'mzJ`z')

-- Move up and down, centering text
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')

-- Replace without losing word in register
map('x', '<leader>p', '\"_dP"')

-- Copy into system clipboard
map('n', '<leader>y', '\"+y')
map('v', '<leader>y', '\"+y')
map('n', '<leader>Y', '\"+Y')

-- Replace the word I'm on for the entire file
map('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

