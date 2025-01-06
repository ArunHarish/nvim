local function filepath()
  local file_path = vim.fn.expand('%:~:.:h')
  local path_result = {}
  -- Show only the leading one pathname and the trailing two pathname
  for pathname in string.gmatch(file_path, "[^/]+") do
    table.insert(path_result, pathname)
  end

  if #path_result > 4 then
    -- Remove the middle elements
    return string.format("%s/%s/.../%s/%s", path_result[1], path_result[2], path_result[3], path_result[4])
  end

  return table.concat(path_result, "/")
end

require('lualine').setup {
	options = {
		theme = 'auto',
	},
  sections = {
    lualine_c = {
    },
  },
  winbar = {
    lualine_a = {
      {
          "navic",
          color_correction = nil,
          navic_opts = nil
      }
    },
    lualine_y = {
      filepath,
    }
  }
}
