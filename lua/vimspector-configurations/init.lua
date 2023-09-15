vim.keymap.set('n', '<leader>Dl', function() vim.call('vimspector#Launch') end, {})
vim.keymap.set('n', '<leader>Dc', function() vim.call('vimspector#Continue') end, {})
vim.keymap.set('n', '<leader>Di', function() vim.call('vimspector#StepInto') end, {})
vim.keymap.set('n', '<leader>Do', function() vim.call('vimspector#StepOut') end, {})
vim.keymap.set('n', '<leader>Dn', function() vim.call('vimspector#StepOver') end, {})
vim.keymap.set('n', '<leader>Dr', function() vim.call('vimspector#Restart') end, {})
vim.keymap.set('n', '<leader>Dx', function() vim.call('vimspector#Reset') end, {})
vim.keymap.set('n', '<leader>Dbt', function() vim.call('vimspector#ToggleBreakpoint') end, {})
vim.keymap.set('n', '<leader>DbH', function()
  vim.ui.input({
    prompt = "Enter your hit condition: ",
    default = "",
  },
    function(input)
      if input then
        vim.fn["vimspector#ToggleBreakpoint"]({
          hitCondition = input,
        })
      end
    end
  )
end, {})
vim.keymap.set('n', '<leader>DbL', function()
  vim.ui.input({
    prompt = "Enter your logpoint: ",
    default = "",
  },
    function(input)
      if input then
        vim.fn["vimspector#ToggleBreakpoint"]({
          logMessage = input,
        })
      end
    end
  )
end, {})
vim.keymap.set('n', '<leader>DbC', function()
  vim.ui.input({
    prompt = "Enter your breakpoint condition: ",
    default = "",
  },
    function(input)
      if input then
        vim.fn["vimspector#ToggleBreakpoint"]({
          condition = input,
        })
      end
    end
  )
end, {})
vim.keymap.set('n', '<leader>Dbc', function() vim.call('vimspector#ClearBreakpoints') end, {})
vim.keymap.set('n', '<leader>Dbl', function() vim.call('vimspector#ListBreakpoints') end, {})
vim.keymap.set('n', ']b', function() vim.call('vimspector#JumpToNextBreakpoint') end, {})
vim.keymap.set('n', '[b', function() vim.call('vimspector#JumpToPreviousBreakpoint') end, {})
