-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- {{ Theme }}
    -- use { 'navarasu/onedark.nvim' }
    use 'Mofiqul/vscode.nvim'

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate'})

    use 'theprimeagen/harpoon'
    use 'mbbill/undotree'

    use 'tpope/vim-fugitive'

    use 'machakann/vim-sandwich'
    use 'nvim-lualine/lualine.nvim'
    use 'nvim-tree/nvim-tree.lua'
    use 'ap/vim-css-color'
    use {
        "folke/trouble.nvim",
        requires = "nvim-tree/nvim-web-devicons",
        config = function()
            require("trouble").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {                                      -- Optional
            'williamboman/mason.nvim',
            run = function()
                pcall(vim.cmd, 'MasonUpdate')
            end,
            },
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},     -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'L3MON4D3/LuaSnip'}     -- Required
        }
    }
    use 'jose-elias-alvarez/null-ls.nvim'
    use { 'akinsho/git-conflict.nvim', tag = 'v1.0.0' }
    use {
        'lewis6991/gitsigns.nvim',
        tag = 'release' -- To use the latest release (do not use this if you run Neovim
        -- nightly or dev builds!)
    }
    use {
        'kkoomen/vim-doge',
        run = ':call doge#install()'
    }
    use {
        "windwp/nvim-autopairs"
    }

    -- {{ Commenting }}
    use 'numToStr/Comment.nvim'
end)
