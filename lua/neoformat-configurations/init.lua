vim.cmd[[let g:neoformat_try_node_exe=1]]
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.ts", "*.js", "*.tsx", "*.jsx" },
  callback = function()
    vim.cmd("Neoformat prettier")
    if vim.fn.exists(':EslintFixAll') > 0 then
      vim.cmd("EslintFixAll")
    else
      print('Warning: Eslint not found')
    end
  end
})
