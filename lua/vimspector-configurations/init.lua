vim.keymap.set('n', ']vl', function() vim.call('vimspector#Launch') end, {})
vim.keymap.set('n', ']vc', function() vim.call('vimspector#Continue') end, {})
vim.keymap.set('n', ']vi', function() vim.call('vimspector#StepInto') end, {})
vim.keymap.set('n', ']vo', function() vim.call('vimspector#StepOut') end, {})
vim.keymap.set('n', ']vn', function() vim.call('vimspector#StepOver') end, {})
vim.keymap.set('n', ']vr', function() vim.call('vimspector#Restart') end, {})
vim.keymap.set('n', ']vx', function() vim.call('vimspector#Reset') end, {})
vim.keymap.set('n', ']vbt', function() vim.call('vimspector#ToggleBreakpoint') end, {})
vim.keymap.set('n', ']vbH', function()
  vim.ui.input({
    prompt = 'Enter your hit condition: ',
    default = '',
  },
    function(input)
      if input then
        vim.fn['vimspector#ToggleBreakpoint']({
          hitCondition = input,
        })
      end
    end
  )
end, {})
vim.keymap.set('n', ']vbL', function()
  vim.ui.input({
    prompt = 'Enter your logpoint: ',
    default = '',
  },
    function(input)
      if input then
        vim.fn['vimspector#SetLineBreakpoint']({
          logMessage = input,
        })
      end
    end
  )
end, {})
vim.keymap.set('n', ']vbC', function()
  vim.ui.input({
    prompt = 'Enter your breakpoint condition: ',
    default = '',
  },
    function(input)
      if input then
        vim.fn['vimspector#ToggleBreakpoint']({
          condition = input,
        })
      end
    end
  )
end, {})
vim.keymap.set('n', ']vbc', function() vim.call('vimspector#ClearBreakpoints') end, {})
vim.keymap.set('n', ']vbl', function() vim.call('vimspector#ListBreakpoints') end, {})
vim.keymap.set('n', ']b', function() vim.call('vimspector#JumpToNextBreakpoint') end, {})
vim.keymap.set('n', '[b', function() vim.call('vimspector#JumpToPreviousBreakpoint') end, {})
