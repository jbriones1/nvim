-- This file can be loaded by calling `lua require('plugins')` from your init.vim
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()


-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- {{ Telescope }}
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use 'nvim-telescope/telescope-ui-select.nvim'

    -- {{ Theme }}
    -- use { "ellisonleao/gruvbox.nvim" }
    use 'folke/tokyonight.nvim'

    -- {{ Syntax highlighting }}
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use 'theHamsta/nvim-semantic-tokens'

    use 'theprimeagen/harpoon'
    use 'mbbill/undotree'

    -- {{ Brackets/tags }}
    use 'machakann/vim-sandwich'
    use {
        "windwp/nvim-autopairs"
    }

    -- {{ Editor UI }}
    use 'nvim-lualine/lualine.nvim'
    use 'nvim-tree/nvim-tree.lua'
    use { 'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons' }
    use 'petertriho/nvim-scrollbar'

    -- {{ Error highlighting }}
    use {
        "folke/trouble.nvim",
        requires = "nvim-tree/nvim-web-devicons"
    }
    use 'folke/lsp-colors.nvim'

    -- {{ LSP }}
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {
                -- Optional
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
            { 'hrsh7th/cmp-buffer' },   -- Suggestions based on current file
            { 'hrsh7th/cmp-path' },     -- Suggestions based on file system
            { 'saadparwaiz1/cmp_luasnip' }
        }
    }
    use 'jose-elias-alvarez/null-ls.nvim'
    use 'jay-babu/mason-null-ls.nvim'

    -- {{ Git }}
    use { 'akinsho/git-conflict.nvim', tag = 'v1.*' }
    use {
        'lewis6991/gitsigns.nvim',
        tag = 'release' -- To use the latest release (do not use this if you run Neovim
        -- nightly or dev builds!)
    }
    use 'tpope/vim-fugitive'

    -- {{ Commenting }}
    use 'numToStr/Comment.nvim'
    use {
        'kkoomen/vim-doge',
        run = ':call doge#install()'
    }

    use 'folke/which-key.nvim'

    -- {{ Session management }}
    use 'rmagatti/auto-session'


    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
