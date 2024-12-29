local server = { "tsserver", "eslint", "cssls", "lua_ls", "emmet_ls", "pyright", "html", "omnisharp", "yamlls", "clangd", "jsonls", "terraformls", "docker_compose_language_service", "bashls", "vimls", "snyk_ls", "biome" }

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

lspconfig.vimls.setup {}
lspconfig.clangd.setup {}
lspconfig.bashls.setup {}
lspconfig.terraformls.setup {}
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
lspconfig.jsonls.setup {}
lspconfig.docker_compose_language_service.setup {}
lspconfig.biome.setup {}

vim.api.nvim_create_autocmd({ "LspAttach" }, {
	callback = function(event)
		local opts = { buffer = event.buf }
    vim.keymap.set('n', ']o', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[e', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']e', vim.diagnostic.goto_next, opts)

		vim.keymap.set('n', ']gd', function() vim.lsp.buf.definition({ jump_type='tab', reuse_win=true, }) end, opts)
    vim.keymap.set('n', ']gD', function() vim.lsp.buf.definition({ jump_type='tabn', reuse_win=true, }) end, opts)

		vim.keymap.set('n', ']gr', function() vim.lsp.buf.references({ jump_type='tab', reuse_win=true }) end, opts)

		vim.keymap.set('n', ']gi', function() vim.lsp.buf.implementation({ jump_type='tab', reuse_win=true }) end, opts)
    vim.keymap.set('n', ']sign', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', ']act', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', ']rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', ']hmm', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', ']tc', function()
        vim.cmd("tabo")
      end
    )
	end
})
