local chat = require('CopilotChat')

vim.g.copilot_workspace_folders = vim.fn.getcwd()

chat.setup {
  enabled = false,
  model = 'claude-sonnet-4.6',
  window = {
    layout = 'float',
    width = 0.75,
    height = 0.5,
    border = 'rounded',
    title = '🤖 AI Assistant',
  },

  headers = {
    user = '👤 You',
    assistant = '🤖 Copilot',
    tool = '🔧 Tool',
  },

  mappings = {
    complete = {
      normal = '<Enter>',
      insert = '<C-y>',
    }
  },

  auto_fold = true,
}
