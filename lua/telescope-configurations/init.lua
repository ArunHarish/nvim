local builtin = require('telescope.builtin')
local telescope = require('telescope')
local actions = require "telescope.actions"

telescope.setup {
	extensions = {
		file_browser = {
			mappings = {
				i = {
					["<C-t>"] = actions.select_tab,
				}
			}
		}
	}
}

telescope.load_extension('live_grep_args')
telescope.load_extension('file_browser')

vim.keymap.set('n', '<leader>fr', builtin.resume, {})
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', telescope.extensions.live_grep_args.live_grep_args, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<space>fc', builtin.colorscheme, {})
vim.keymap.set('n', '<space>fb',  function ()
		telescope.extensions.file_browser.file_browser {
			path = "%:p:h"
		}
	end,
{ noremap = true })
vim.keymap.set('n', '<space>fl', builtin.lsp_document_symbols, {})
