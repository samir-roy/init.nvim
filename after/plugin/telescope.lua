local telescope = require('telescope')

telescope.setup {
  defaults = {
    layout_strategy = 'vertical',
    mappings = {
      n = {
        ["q"] = "close",
      }
    }
  },
  pickers = {
    buffers = {
      show_all_buffers = true,
      sort_lastused = true,
      mappings = {
        i = {
          ["<c-d>"] = "delete_buffer",
        },
        n = {
          ["d"] = "delete_buffer",
          ["x"] = "delete_buffer",
        }
      }
    }
  }
}

telescope.load_extension('recent_files')
