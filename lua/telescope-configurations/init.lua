local builtin = require('telescope.builtin')
local telescope = require('telescope')
local actions = require "telescope.actions"

telescope.setup {
  defaults = {
    display_stat = { date = true, size = true },
    layout_config = {
      horizontal = {
        prompt_position = 'top',
        preview_width = 0.70,
      }
    },
    path_display = {'smart'},
  },
	extensions = {
		file_browser = {
      git_status = true,
      hijack_netrw = true,
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

vim.keymap.set('n', '<leader>Sr', builtin.resume, {})
vim.keymap.set('n', '<leader>Sf', builtin.find_files, {})
vim.keymap.set('n', '<leader>Sg', telescope.extensions.live_grep_args.live_grep_args, {})
vim.keymap.set('n', '<leader>Sb', builtin.buffers, {})
vim.keymap.set('n', '<leader>Sc', builtin.colorscheme, {})
vim.keymap.set('n', '<leader>gs', builtin.git_status, {})
vim.keymap.set('n', '<leader>dd', function()
  builtin.diagnostics {
    bufnr = 0,
  }
  end,
{})
vim.keymap.set('n', '<leader>dl', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<space>fb',  function ()
  telescope.extensions.file_browser.file_browser {
    path = "%:p:h"
  }
	end,
{ noremap = true })
