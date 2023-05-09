vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = { { 'nvim-lua/plenary.nvim' } } }
    use('ellisonleao/gruvbox.nvim')
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('tpope/vim-fugitive')
    use('tpope/vim-rhubarb')
    use('airblade/vim-gitgutter')
    use('vim-test/vim-test')
    use('jose-elias-alvarez/null-ls.nvim') -- Allows use of code actions
    use('tpope/vim-commentary')
    use { "akinsho/toggleterm.nvim", tag = '*', config = function()
        require("toggleterm").setup()
    end }

    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },
        }
    }
end)

-- Snippets
-- {'L3MON4D3/LuaSnip'},
--use('ggandor/leap.nvim')
--use('ThePrimeagen/harpoon')
--use('mbbill/undotree')
--{'rafamadriz/friendly-snippets'},
--use('nvim-treesitter/playground')
-- use('nvim-lualine/lualine.nvim')
