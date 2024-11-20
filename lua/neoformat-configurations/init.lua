vim.cmd[[let g:neoformat_try_node_exe=1]]
local function choose_formatter(event)
  local clients = vim.lsp.get_clients({ bufnr = event.bufnr })
  for _, client in pairs(clients) do
   if client.name == "biome" and client.root_dir and string.len(client.root_dir) > 0 then
      vim.cmd("Neoformat biome")
      return
   end
  end
  vim.cmd("Neoformat prettier")
end
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.ts", "*.js", "*.tsx", "*.jsx", "*.mjs" },
  callback = function(event)
    choose_formatter(event)
    if vim.fn.exists(':EslintFixAll') > 0 then
      vim.cmd("EslintFixAll")
    else
      print('Warning: Eslint not found')
    end
  end
})
