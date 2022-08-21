local themes = require "telescope.themes"
local M = {}

function M.my_buffers()
  require('telescope.builtin').buffers(
    require('telescope.themes').get_dropdown {
      previewer = false,
      only_cwd = vim.fn.haslocaldir() == 1,
      show_all_buffers = false,
      sort_mru = true,
      ignore_current_buffer = false,
      sorter = require('telescope.sorters').get_substr_matcher(),
      selection_strategy = 'closest',
      path_display = { 'shorten' },
      layout_strategy = 'center',
      winblend = 0,
      layout_config = { width = 70 },
      color_devicons = true,
    }
  )
end

return M
