local server = { "tsserver", "eslint", "cssls", "lua_ls", "emmet_ls", "pyright", "html", "omnisharp", "yamlls" }

require('mason').setup {
	ensure_installed = server,
	automatic_installation = true
}
require('mason-lspconfig').setup()

local lspconfig = require('lspconfig')

lspconfig.tsserver.setup {
	filetypes = { "typescript", "typescriptreact", "javascript" },
	root_dir = function()
		return vim.loop.cwd()
	end
}

lspconfig.eslint.setup {}
lspconfig.cssls.setup {}
lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnositcs = {
        globals = {
          'vim',
          'require',
        }
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      }
    }
  }
}
lspconfig.emmet_ls.setup {}
lspconfig.pyright.setup {}
lspconfig.html.setup {}
lspconfig.omnisharp.setup {}
lspconfig.yamlls.setup {}

vim.api.nvim_create_autocmd({ "LspAttach" }, {
	callback = function(event)
		local opts = { buffer = event.buf }
    vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<leader>d[', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', '<leader>d]', vim.diagnostic.goto_next, opts)
		vim.keymap.set('n', '<leader>gtd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', '<leader>gtr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', '<leader>gti', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<leader>magic', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>hmm', vim.lsp.buf.hover, opts)
    -- Temporary fix for OmniSharp :cry:
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client.name == 'omnisharp' then
      local function toSnakeCase(str)
        return string.gsub(str, "%s*[- ]%s*", "_")
      end
      local tokenModifiers = client.server_capabilities.semanticTokensProvider.legend.tokenModifiers
      for i, v in ipairs(tokenModifiers) do
        tokenModifiers[i] = toSnakeCase(v)
      end
      local tokenTypes = client.server_capabilities.semanticTokensProvider.legend.tokenTypes
      for i, v in ipairs(tokenTypes) do
        tokenTypes[i] = toSnakeCase(v)
      end
    end
	end
})
