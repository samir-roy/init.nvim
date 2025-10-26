-- IMPORTANT
-- ---------
-- files in after/plugin are executed in alphabetical order
-- this file is named zzzrunlast.lua to ensure it is loaded last
-- keymaps are set the end of this file after loading all plugins

require('code-bridge').setup({
  tmux = {
    window_name = 'opencode',
    process_name = 'opencode',
  }
})

require('nvim-surround').setup()

require('nvim_comment').setup({
  -- don't comment empty lines
  comment_empty = false,
})

require('spectre').setup({
  color_devicons = false,
  -- leader-a will repeat last search
  mapping = {
    ['resume_last_search'] = {
      map = "<leader>a",
      cmd = "<cmd>lua require('spectre').resume_last_search()<CR>",
      desc = "repeat last search"
    },
  }
})

-- keymaps for plugins are set at end
require('keymaps').set_keymaps_for_plugins()
