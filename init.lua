local opt = vim.opt
local Plug = vim.fn['plug#']

-- Vim options
opt.number = true
opt.rnu = true
opt.ts = 2
opt.sw = 2
opt.expandtab = true
opt.splitright = true
opt.autoread = true
opt.switchbuf= 'usetab'
opt.foldmethod = 'syntax'
opt.foldlevel = 999
opt.clipboard = 'unnamed'

vim.call('plug#begin')

-- Debugger
Plug ('puremourning/vimspector')

-- Theme Plugins
Plug ('folke/tokyonight.nvim', { branch= 'main' })
Plug ('olimorris/onedarkpro.nvim')
Plug ('morhetz/gruvbox')
Plug ('ayu-theme/ayu-vim')
Plug ('projekt0n/github-nvim-theme')
Plug ('catppuccin/nvim', { as = 'catppuccin-mocha' })

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
Plug ('akinsho/bufferline.nvim')

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

-- Git plugin 
Plug 'lewis6991/gitsigns.nvim'

-- navic
Plug 'SmiteshP/nvim-navic'

-- fzf
Plug ('junegunn/fzf', { ['do'] = function ()
  vim.fn["fzf#install"]()
  end
})

vim.call('plug#end')

-- Vim colorschemes
vim.cmd[[let ayucolor="dark"]]
vim.cmd.colorscheme('github_light')

-- Vim highlights
vim.api.nvim_set_hl(0, 'Comment', { italic=true })

-- General keymaps 
vim.keymap.set('n', '<space>q',vim.cmd.ccl, {});

-- Vim configurations
require'tabline-configurations'
require'lsp-configurations'
require'gitsigns-configurations'
require'cmp-configurations'
require'telescope-configurations'
require'format-configurations'
require'vimspector-configurations'
require'transparent-mode-configurations'
require'lualine-configurations'
require'navic-configurations'
