require'gitsigns'.setup {
  current_line_blame =  true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 500,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  on_attach = function (bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    map('n', ']c', function ()
      if vim.wo.diff then return ']c' end
      vim.schedule(function ()
        gs.next_hunk()
      end)
    end)

    map('n', '[c', function ()
      if vim.wo.diff then return ']c' end
      vim.schedule(function ()
        gs.prev_hunk()
      end)
    end)

  end
}
