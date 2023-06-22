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
opt.switchbuf= 'newtab'

vim.call('plug#begin')
-- Theme Plugins
Plug ('folke/tokyonight.nvim', { branch= 'main' })
Plug ('olimorris/onedarkpro.nvim')
Plug ('morhetz/gruvbox')

-- UI Plugins
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-lua/plenary.nvim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'ap/vim-css-color'

Plug ('nvim-telescope/telescope.nvim')
Plug ('nvim-telescope/telescope-live-grep-args.nvim')
Plug ('nvim-telescope/telescope-file-browser.nvim')
Plug ('tpope/vim-rhubarb')

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
vim.cmd.colorscheme('onedark')

-- Vim highlights
vim.api.nvim_set_hl(0, 'Comment', { italic = true })


-- Lualine configurations
local function showBufferNumber()
  return vim.fn.bufnr()
end

require('lualine').setup {
	options = {
		theme = 'onedark',
	},
  sections = {
    lualine_c = {
      {
        'datetime',
        style = '%H:%M:%S',
      },
      showBufferNumber,
    },
  }
}

-- General keymaps 
vim.keymap.set('n', '<space>q',vim.cmd.ccl, {});

-- Vim configurations
require'lsp-configurations'
require'gitsigns-configurations'
require'cmp-configurations'
require'telescope-configurations'
require'neoformat-configurations'
