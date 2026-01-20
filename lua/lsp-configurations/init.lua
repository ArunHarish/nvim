local server = { "ts_ls", "eslint", "cssls", "lua_ls", "emmet_ls", "pyright", "html", "omnisharp", "yamlls", "clangd", "jsonls", "terraformls", "docker_compose_language_service", "bashls","rust_analyzer", "vimls", "snyk_ls", "biome", "gopls" }

local lspconfig = require('lspconfig')

require('mason').setup {
	ensure_installed = server,
	automatic_installation = true
}
require('mason-lspconfig').setup()

vim.lsp.config('ts_ls', {
	filetypes = { 'typescript', 'typescriptreact', 'javascript', 'typescript.tsx', 'javascriptreact' },
	root_dir = vim.loop.cwd(),
})
vim.lsp.enable('ts_ls')

vim.lsp.config('gopls', {
  default_config = {
    cmd = { 'gopls' },
    filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
    root_dir = function(fname)
      local mod_cache = '/root/go/pkg/mod'
      -- see: https://github.com/neovim/nvim-lspconfig/issues/804
      if not mod_cache then
        local result = vim.lspconfig.async.run_command 'go env GOMODCACHE'
        if result and result[1] then
          mod_cache = vim.trim(result[1])
        end
      end
      if fname:sub(1, #mod_cache) == mod_cache then
        local clients = vim.lsp.get_clients { name = 'gopls' }
        if #clients > 0 then
          return clients[#clients].config.root_dir
        end
      end
      return vim.lspconfig.util.root_pattern 'go.work'(fname) or vim.lspconfig.util.root_pattern('go.mod', '.git')(fname)
    end,
    single_file_support = true,
  },
})
vim.lsp.enable('gopls')

vim.lsp.config('rust_analyzer', {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_dir = vim.loop.cwd(),
})
vim.lsp.enable('rust_analyzer')

vim.lsp.enable('vimls')
vim.lsp.config('clangd', {
  cmd = { 'clangd' },
  filetypes = { 'c', 'h' },
});
vim.lsp.enable('clangd')
vim.lsp.enable('bashls')
vim.lsp.enable('terraformls')

vim.lsp.config('eslint', {
  root_dir = lspconfig.util.root_pattern('.eslintrc.js', '.eslintrc.cjs', '.eslintrc.yaml', '.eslintrc.yml', '.eslintrc.json', 'package.json', '.git'),
})
vim.lsp.enable('eslint')

vim.lsp.enable('cssls')

vim.lsp.config('lua_ls', {
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
})
vim.lsp.enable('lua_ls')

vim.lsp.enable('emmet_ls')
vim.lsp.enable('pyright')
vim.lsp.enable('html')
vim.lsp.enable('omnisharp')
vim.lsp.enable('yamlls')
vim.lsp.enable('jsonls')
vim.lsp.enable('docker_compose_language_service')

-- Formatters
vim.lsp.config('biome', {
  filetypes = { "typescript", "typescriptreact", "javascript", "typescript.tsx", "javascriptreact", "json" },
})
vim.lsp.enable('biome')
vim.diagnostic.jump({ severity = vim.diagnostic.severity.ERROR, count = 1 })
vim.api.nvim_create_autocmd({ "LspAttach" }, {
	callback = function(event)
		local opts = { buffer = event.buf }
    vim.keymap.set('n', ']o', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[e', function() vim.diagnostic.jump({ count = -1 }) end, opts)
    vim.keymap.set('n', ']e', function () vim.diagnostic.jump({ count = 1 }) end, opts)
    vim.keymap.set('n', '[E', function () vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR }) end, opts)
    vim.keymap.set('n', ']E', function () vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR }) end, opts)
    vim.keymap.set('n', ']gd', function() vim.lsp.buf.definition({ jump_type='tab', reuse_win=true, }) end, opts)
    vim.keymap.set('n', ']gD', function() vim.lsp.buf.definition({ jump_type='tabn', reuse_win=true, }) end, opts)
		vim.keymap.set('n', ']gr', function() vim.lsp.buf.references({ jump_type='tab', reuse_win=true, includeDeclaration=false }) end, opts)
		vim.keymap.set('n', ']gi', function() vim.lsp.buf.implementation({ jump_type='tab', reuse_win=true }) end, opts)
		vim.keymap.set('n', ']act', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', ']rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', ']tc', function() vim.cmd("tabo") end)
	end
})
