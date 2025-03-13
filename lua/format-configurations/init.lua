vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.ts", "*.js", "*.tsx", "*.jsx", "*.mjs", "*.rs" },
  callback = function(event)
    vim.lsp.buf.format()
    if vim.fn.exists(':EslintFixAll') > 0 then
      vim.cmd("EslintFixAll")
    else
      print('Warning: Eslint not found')
    end
  end
})
