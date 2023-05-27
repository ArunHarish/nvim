local opt = vim.opt
local Plug = vim.fn['plug#']

-- Vim options
opt.number = true
opt.ts = 2
opt.sw = 2
opt.expandtab = true
opt.splitright = true
opt.autoread = true
opt.guitablabel= '%t'

vim.call('plug#begin')
-- Theme Plugins
Plug ('folke/tokyonight.nvim', { branch= 'main' })
Plug ('morhetz/gruvbox')

-- UI Plugins
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-lua/plenary.nvim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'ap/vim-css-color'

Plug ('nvim-telescope/telescope.nvim', { tag = '0.1.1' })
Plug ('nvim-telescope/telescope-live-grep-args.nvim')
Plug ('nvim-telescope/telescope-file-browser.nvim')

-- LSP Manager 
Plug ('williamboman/mason.nvim', { ['do'] = function()
		vim.call('MasonUpdate')
	end
})

Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'tpope/vim-fugitive'

-- Neoformat
Plug 'sbdchd/neoformat'

-- Git plugin 
Plug 'lewis6991/gitsigns.nvim'

vim.call('plug#end')

-- Vim colorschemes
vim.api.nvim_command [[colorscheme gruvbox]]

-- Vim configurations
require'lsp-configurations'

-- Lualine configurations
local function showBufferNumber()
  return vim.fn.bufnr()
end

require('lualine').setup {
	options = {
		theme = 'gruvbox',
	},
  sections = {
    lualine_c = {
      'datetime',
      showBufferNumber,
    },
  }
}


require'gitsigns-configurations'
require'cmp-configurations'
require'telescope-configurations'
require'neoformat-configurations'