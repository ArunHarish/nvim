local ToggleConfig = {}

function ToggleConfig.is_copilot_enabled()
  return vim.fn.getenv('NVIM_ENABLE_COPILOT') ~= vim.NIL and vim.fn.getenv('NVIM_ENABLE_COPILOT') == 'true'
end

return ToggleConfig
