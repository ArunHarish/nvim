local configPath = vim.fn.stdpath('config')

local shellPath = {}

if type(configPath) == "table" then
  for _, value in ipairs(configPath) do
    table.insert(shellPath, value)
  end
elseif type(configPath) == "string" then
    table.insert(shellPath, configPath)
end

table.insert(shellPath, 'theme-listener/target/release/theme-listener')

vim.fn.jobstart({ table.concat(shellPath, '/') }, {
  stdout_buffered = false,
  on_stdout = function(_, data)
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

