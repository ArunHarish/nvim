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
    local biome_client = vim.lsp.get_clients({
      bufnr = event.bufnr,
      name = "biome",
    })

    local eslint_client = vim.lsp.get_clients({
      bufnr = event.bufnr,
      name = "eslint",
    })

    -- Use biome if it's available else check eslint otherwise use neoformat
    if #biome_client > 0 or #eslint_client > 0 then
      vim.lsp.buf.format()
    else
      vim.cmd("Neoformat prettier")
    end
  end
})
