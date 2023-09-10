vim.opt.termguicolors = true
require'bufferline'.setup{
  options = {
    mode = 'tabs',
    diagnostics = 'nvim_lsp',
    max_name_length = 25,
    truncate_names = false,
    numbers = function(opts)
      -- Find window ID
      local currentWindowID = vim.api.nvim_tabpage_get_win(opts.id)
      local windowIDs = vim.api.nvim_tabpage_list_wins(opts.id)
      local bufferNumber = vim.fn.winbufnr(currentWindowID)
      local multiWindowTabTitle = ''

      if #windowIDs > 1 then
        multiWindowTabTitle = '〓'
      end

      if bufferNumber then
        return string.format("%s %s.%s", multiWindowTabTitle, opts.lower(bufferNumber), opts.raise(opts.id))
      end

      return multiWindowTabTitle
    end,
  },
}

