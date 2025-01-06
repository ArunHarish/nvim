vim.opt.termguicolors = true
require'bufferline'.setup{
  highlights = {
    indicator_selected = {
      fg = '#ff0000',
    }
  },
  options = {
    mode = 'tabs',
    diagnostics = 'nvim_lsp',
    max_name_length = 25,
    tab_size = 25,
    truncate_names = false,
    numbers = function(opts)
      local last_accessed_tab = vim.fn.tabpagenr('#')
      local tab_number = vim.api.nvim_tabpage_get_number(opts.id)

      -- Find window ID
      local current_win_id = vim.api.nvim_tabpage_get_win(opts.id)
      local win_ids = vim.api.nvim_tabpage_list_wins(opts.id)
      local buffer_number = vim.fn.winbufnr(current_win_id)
      local special_tab_icon = ''

      if #win_ids > 1 then
        special_tab_icon = '〓'
      end

      if tab_number == last_accessed_tab then
        special_tab_icon = special_tab_icon..'⇆'
      end


      if buffer_number then
        return string.format('%s %s.%s', special_tab_icon, opts.lower(buffer_number), opts.raise(opts.id))
      end

      return special_tab_icon
    end,
  },
}

