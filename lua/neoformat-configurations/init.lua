
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.ts", "*.js", "*.tsx", "*.jsx" },
  callback = function()
    vim.cmd("Neoformat prettier")
    vim.cmd("EslintFixAll")
  end
})
