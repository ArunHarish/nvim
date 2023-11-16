local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local utils = require('telescope.utils')
local action_utils = require('telescope.actions.utils')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local previewers = require('telescope.previewers')

local CustomExtensions = {}

local get_window_tab_pages = function ()
  local table_list = {}
  local current_window = vim.api.nvim_get_current_win()
  local tabpages = vim.api.nvim_list_tabpages()

  -- for each tab page find its windows
  for _, tabpage in ipairs(tabpages) do
    -- List all windows
    local windowList = vim.api.nvim_tabpage_list_wins(tabpage)
    for _, window in ipairs(windowList) do
      local buffer = vim.api.nvim_win_get_buf(window)
      local bufferPath = vim.api.nvim_buf_get_name(buffer)

      if window ~= current_window then
        table.insert(table_list, {
          tabpage = tabpage,
          window = window,
          buffer = buffer,
          path = bufferPath,
        })
      end
    end
  end

  return table_list
end

local attach_mapping_listeners = function(prompt_number)
  return {
    on_select = function()
      actions.close(prompt_number)
      local selection = action_state.get_selected_entry()
      -- Go to selected window
      vim.api.nvim_set_current_win(selection.windowID)
    end,
    on_selection_delete = function()
      action_utils.map_selections(prompt_number, function(selection)
        utils.win_delete(nil, selection.windowID, true, false)
      end)
      actions.close(prompt_number)
    end
  }
end


CustomExtensions.search_tab_pages = function ()
  local tabpageList = get_window_tab_pages()
  local config = {}

  pickers.new(config, {
    prompt_title = 'Showing other windows',
    finder = finders.new_table {
      results = tabpageList,
      entry_maker = function(entry)
        local devicons = utils.get_devicons(entry.path)
        local basename = utils.transform_path({
          path_display = {
            absolute = false,
          }
        }, entry.path)
        local display = string.format("%d %s %s", entry.tabpage, devicons, basename)
        return {
          display = display,
          ordinal = entry.path,
          tabpageID = entry.tabpage,
          bufferID = entry.buffer,
          windowID = entry.window,
        }
      end
    },
    sorter = conf.file_sorter(config),
    attach_mappings = function(prompt_number, map)
      local listeners = attach_mapping_listeners(prompt_number)

      map('i', '<CR>', listeners.on_select)
      map('i', '<C-d>', listeners.on_selection_delete)
      map('n', '<C-d>', listeners.on_selection_delete)

      return true
    end,
    previewer = previewers.new_buffer_previewer {
      title = "Tab preview",
      get_buffer_by_name = function (_, entry)
        return entry.display
      end,
      define_preview = function(self, entry)
        -- Set the buffer preview
        previewers.buffer_previewer_maker(entry.ordinal, self.state.bufnr, {
          winid = self.state.winid,
          callback = function()
            local cursor_position = vim.api.nvim_win_get_cursor(entry.windowID)
            vim.api.nvim_win_set_cursor(self.state.winid, cursor_position)
          end
        })
      end,
    },
  }):find()
end

return CustomExtensions
