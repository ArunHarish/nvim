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
    lualine_c = {
      {
          "navic",
          color_correction = nil,
          navic_opts = nil
      }
    }
  }
}
