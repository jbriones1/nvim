-- {{ Functions }}
local g = vim.g
local o = vim.opt

function Map(mode, alias, curr, options)
    local opts = options or {}
    vim.keymap.set(mode, alias, curr, opts)
end

-- {{ Config }}
g.mapleader = ' '
g.maplocalleader = ' '

o.guifont = 'Hack NFM'
-- Line numbers
o.relativenumber = true
o.number = true

-- Four space indent
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smartindent = true

o.autoindent = true
o.history = 50       -- Remember 50 items in commandline history
o.updatetime = 200   -- Decrease update time
o.signcolumn = 'yes' -- Always show sign column
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

-- Blinking cursor
o.guicursor = 'n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkon200'

-- Highlight region on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

-- {{ Keybinds }}
Map('n', ';', ':', { silent = true })
Map('n', ',', '@q', { silent = true })
Map('n', '<Enter>', 'o<Esc>', { silent = true })
Map('n', '<S-Enter>', 'O<Esc>', { silent = true })
Map('n', '<leader>q', ':b#<bar>bd#<CR>', { silent = true })

-- Moving windows
Map('n', '<C-h>', '<C-W><C-H>', { silent = true })
Map('n', '<C-j>', '<C-W><C-J>', { silent = true })
Map('n', '<C-k>', '<C-W><C-K>', { silent = true })
Map('n', '<C-l>', '<C-W><C-L>', { silent = true })

-- Moving text while highlighted
Map('v', 'J', ":m '>+1<CR>gv=gv", { silent = true })
Map('v', 'K', ":m '<-2<CR>gv=gv", { silent = true })

-- Append next line to end without moving cursor
Map('n', 'J', 'mzJ`z', { silent = true })

-- Move up and down, centering text
Map('n', '<C-d>', '<C-d>zz', { silent = true })
Map('n', '<C-u>', '<C-u>zz', { silent = true })

-- Replace without losing word in register
Map('x', '<leader>p', '\"_dP"', { silent = true })

-- Copy into system clipboard
Map('n', '<leader>y', '\"+y', { silent = true })
Map('v', '<leader>y', '\"+y', { silent = true })
Map('n', '<leader>Y', '\"+Y', { silent = true })

-- Replace the word I'm on for the entire file
Map('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { silent = true })
