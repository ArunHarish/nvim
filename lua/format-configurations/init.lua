-- Rust format
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.rs" },
  callback = function(event)
    vim.lsp.buf.format({ bufnr = event.bufnr })
  end
})

-- Typescript/Javascript formats
vim.cmd[[let g:neoformat_try_node_exe=1]]
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.ts", "*.js", "*.tsx", "*.jsx", "*.mjs" },
  callback = function(event)
    if vim.fn.exists(':EslintFixAll') > 0 then
      vim.cmd("EslintFixAll")
    else
      print('Warning: Eslint not found')
    end

    local biome_client = vim.lsp.get_clients({
      bufnr = event.bufnr,
      name = "biome",
    })

    if #biome_client > 0 then
      vim.lsp.buf.format()
    else
      vim.cmd("Neoformat prettier")
    end
  end
})
