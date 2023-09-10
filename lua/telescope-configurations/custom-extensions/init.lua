local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local CustomExtensions = {}

local WindowTabPagesIterator = function ()

  local tabpages = vim.api.nvim_list_tabpages()
  local tabpageIndex = 1
  local windowIndex = 1

  return function ()

    if tabpageIndex > #tabpages then
      return
    end

    -- List all windows 
    local tabpage = tabpages[tabpageIndex]
    local windowList = vim.api.nvim_tabpage_list_wins(tabpage)
    local windowID = windowList[windowIndex]

    -- Current buffer in the window
    local buffer = vim.api.nvim_win_get_buf(windowID)
    local bufferPath = vim.api.nvim_buf_get_name(buffer)

    windowIndex = windowIndex + 1

    if windowIndex > #windowList then
      windowIndex = 1
      tabpageIndex = tabpageIndex + 1
    end

    return {
      window = windowID,
      buffer = buffer,
      path = bufferPath,
    }
  end
end

CustomExtensions.search_tab_pages = function ()
  local tabpageList = {}

  for window in WindowTabPagesIterator() do
    table.insert(tabpageList, window)
  end

  pickers.new({}, {
    prompt_title = 'Tabpages',
    finder = finders.new_table {
      results = tabpageList,
      entry_maker = function(entry)
        return {
          display = entry.path,
          ordinal = entry.path,
          bufferID = entry.buffer,
          windowID = entry.window,
        }
      end
    },
    sorter = conf.file_sorter({}),
    attach_mappings = function(prompt_number)
      actions.select_default:replace(function ()
        actions.close(prompt_number)
        local selection = action_state.get_selected_entry()
        -- Go to selected window
        vim.api.nvim_set_current_win(selection.windowID)
      end)
      return true
    end
  }):find()
end

return CustomExtensions
