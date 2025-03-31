require('nvim-tree').setup({
  hijack_cursor = true,
  sync_root_with_cwd = true,
  actions = {
    change_dir = {
      enable = false,
      restrict_above_cwd = true,
    },
  },
  filters = {
    custom = {
      "^.git$",
    },
  },
  git = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = false,
  },
  renderer = {
    full_name = true,
    group_empty = true,
    symlink_destination = false,
    icons = {
      git_placement = "signcolumn",
      glyphs = {
        folder = {
          arrow_closed = "˖",
          arrow_open = "┬",
          default = "˖",
          open = "┬",
          empty = "˖",
          empty_open = "┬",
          symlink = "˖",
          symlink_open = "┬",
        },
        git = {
          unstaged = "×",
          staged = "✓",
          unmerged = "~",
          renamed = "➜",
          untracked = "★",
          deleted = "⦸",
          ignored = "◌",
        },
      },
      show = {
        file = false,
        folder = true,
        folder_arrow = false,
        git = true,
      },
    },
    indent_markers = {
      enable = true,
    },
  },
  update_focused_file = {
    enable = true,
    update_root = false,
    ignore_list = {},
  },
  view = {
    float = {
      enable = true,
      open_win_config = function()
        local screen_w = vim.opt.columns:get()
        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
        local window_w = screen_w - 40
        local window_h = screen_h - 16
        local center_x = (screen_w - window_w) / 2
        local center_y = (screen_h - window_h - 2) / 2
        return {
          border = 'rounded',
          relative = 'editor',
          col = center_x,
          row = center_y,
          width = window_w,
          height = window_h,
        }
      end,
    },
    width = function()
      return vim.opt.columns:get() - 40
    end,
  },
})
