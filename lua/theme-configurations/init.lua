local THEME_LISTENER_SOCK = "/tmp/theme-listener.sock"
-- If UNIX socket is present
if vim.uv.fs_stat(THEME_LISTENER_SOCK) then
  -- Connect to UNIX socket
  vim.fn.sockconnect("pipe", THEME_LISTENER_SOCK, {
    on_data = function (_, data)
      if data[1] == "dark" then
        vim.cmd.colorscheme('github_dark')
        vim.api.nvim_set_hl(0, 'Visual', { bg='#d1e2f8', fg='#0969da', bold=true })
        vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
        vim.api.nvim_set_hl(0, 'GitSignsCurrentLineBlame', { bg = 'none', fg = '#999999', italic = true })
        vim.api.nvim_set_hl(0, 'LineNr', { bg = 'none', fg = '#999999' })
      elseif data[1] == "light" then
        vim.cmd.colorscheme('github_light')
      end
    end
  })
else
  vim.notify("NOTE: Theme Listener not running")
end

