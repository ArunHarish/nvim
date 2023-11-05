local function filepath()
  local file_path = vim.fn.expand('%:~:.:h')

  return file_path
end

require('lualine').setup {
	options = {
		theme = 'auto',
	},
  sections = {
    lualine_c = {
      {
        'datetime',
        style = '%H:%M:%S',
      },
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
    lualine_x = {
      filepath,
    }
  }
}
