-- Rust format
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = { '*.rs' },
  callback = function(event)
    vim.lsp.buf.format({ bufnr = event.buf })
  end
})

--- Organize imports using Biome LSP
--- @param client vim.lsp.Client
--- @param bufnr number
local function biome_organize_imports(client, bufnr)
  local last_line = vim.api.nvim_buf_line_count(bufnr)
  local last_col = #vim.api.nvim_buf_get_lines(bufnr, last_line - 1, last_line, false)[1]

  local params = {
    textDocument = vim.lsp.util.make_text_document_params(bufnr),
    range = {
      start = { line = 0, character = 0 },
      ['end'] = { line = last_line - 1, character = last_col },
    },
    context = {
      only = { 'source.organizeImports' },
      diagnostics = {},
    },
  }

  local res = client.request_sync(client, 'textDocument/codeAction', params, 5000)
  if not res then
    return
  end

  for _, response in pairs(res) do
    for _, action in pairs(response or {}) do
      if action.edit then
        vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
      end
    end
  end
end
-- Typescript/Javascript formats
vim.cmd[[let g:neoformat_try_node_exe=1]]
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = { '*.ts', '*.js', '*.tsx', '*.jsx', '*.mjs', '*.json' },
  callback = function(event)
    local biome_client_filter = vim.lsp.get_clients({
      bufnr = event.buf,
      name = 'biome',
    })

    local eslint_client_filter = vim.lsp.get_clients({
      bufnr = event.buf,
      name = 'eslint',
    })

    -- Use biome if it's available else check eslint otherwise use neoformat
    if #biome_client_filter > 0 then
      local biome_client = biome_client_filter[1]

      vim.lsp.buf.format()
      biome_organize_imports(biome_client, event.buf)

      return
    elseif #eslint_client_filter > 0 then
      vim.lsp.buf.format()
      return
    else
      vim.cmd('Neoformat prettier')
      return
    end
  end
})
