vim.opt.termguicolors = true
require'bufferline'.setup{
  options = {
    mode = 'tabs',
    tab_size = 20,
    diagnostics = 'nvim_lsp',
    max_name_length = 25,
    truncate_names = false,
    numbers = function(opts)
      -- Find window ID
      local windowID = vim.api.nvim_tabpage_get_win(opts.id)
      local bufferNumber = vim.fn.winbufnr(windowID)
      if bufferNumber then
        return opts.lower(bufferNumber) .. '.' .. opts.raise(opts.id)
      end
      -- If cannot find any just return empty
      return ''
    end,
  },
}

