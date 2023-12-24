vim.cmd [[packadd packer.nvim]]

return require 'packer'.startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Telescope
  use { 'nvim-telescope/telescope.nvim', tag = '0.1.2', requires = { { 'nvim-lua/plenary.nvim' } }
  }

  -- Colorscheme(s)
  use 'sainnhe/sonokai'
  use 'rebelot/kanagawa.nvim'

  -- Git
  use 'lewis6991/gitsigns.nvim'
  use 'tpope/vim-fugitive'
  use 'rbong/vim-flog'

  -- Treesitter highlight code
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- LSP
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    requires = {
      -- LSP Support
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'neovim/nvim-lspconfig' },

      -- CMP
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'L3MON4D3/LuaSnip',                 tag = "v2.*", run = 'make install_jsregexp' },
    }
  }

  -- Explorer
  use { 'nvim-tree/nvim-tree.lua', requires = { { 'nvim-tree/nvim-web-devicons' } } }

  -- CMP
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'hrsh7th/cmp-path'
  use 'saadparwaiz1/cmp_luasnip'

  -- Statusline
  use 'nvim-lualine/lualine.nvim'

  -- Autopairs
  use 'windwp/nvim-autopairs'
end)
