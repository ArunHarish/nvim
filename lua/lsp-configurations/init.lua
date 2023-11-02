local server = { "tsserver", "eslint", "cssls", "lua_ls", "emmet_ls", "pyright", "html", "omnisharp", "yamlls", "clangd" }

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

lspconfig.clangd.setup {}
lspconfig.eslint.setup {}
lspconfig.cssls.setup {}
lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnositics = {
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
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
		vim.keymap.set('n', '<leader>gtd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', '<leader>gtr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', '<leader>gti', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<leader>sigh', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<leader>magic', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>hmm', vim.lsp.buf.hover, opts)
	end
})
