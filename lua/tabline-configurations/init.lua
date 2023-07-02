vim.opt.termguicolors = true
require'bufferline'.setup{
  options = {
    mode = 'tabs',
    name_formatter = function(opts)
      -- If there is only one buffer then return that
      if #(opts.buffers) == 1 then
        return string.format('%s (%d)', opts.name, opts.buffers[1])
      end
      -- Find window ID
      local windowID = vim.api.nvim_tabpage_get_win(opts.tabnr)
      local bufferNumber = vim.fn.winbufnr(windowID)
      if bufferNumber then
        return string.format('%s (%d)', opts.name, bufferNumber)
      end
      -- If cannot find any just return the file name
      return string.format('%s', opts.name, opts.tabnr)
    end
  }
}

