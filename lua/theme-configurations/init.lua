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
    elseif data[1] == "light" then
    end
  end
})

