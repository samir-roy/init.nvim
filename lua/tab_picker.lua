local M = {}

local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local entry_display = require('telescope.pickers.entry_display')
local make_entry = require('telescope.make_entry')

-- Returns table with buffers sorted by buffer number
local function get_sorted_buffers()
  local buffers = {}
  local all_bufs = vim.api.nvim_list_bufs()

  -- Filter to only loaded and listed buffers
  for _, buf in ipairs(all_bufs) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
      table.insert(buffers, buf)
    end
  end

  -- Sort by buffer number
  table.sort(buffers, function(a, b) return a < b end)

  return buffers
end

-- Returns table with {bufnr, original_index} ordered for display
local function get_display_ordered_buffers()
  local sorted_buffers = get_sorted_buffers()
  local current_buf = vim.api.nvim_get_current_buf()
  local alternate_buf = vim.fn.bufnr("#")

  -- Create map of bufnr to original index (for numbering)
  local bufnr_to_index = {}
  for i, buf in ipairs(sorted_buffers) do
    bufnr_to_index[buf] = i
  end

  local ordered = {}

  -- List current buffer first
  for _, buf in ipairs(sorted_buffers) do
    if buf == current_buf then
      table.insert(ordered, { bufnr = buf, original_index = bufnr_to_index[buf] })
      break
    end
  end

  -- List alternate buffer second
  if alternate_buf ~= -1 then
    for _, buf in ipairs(sorted_buffers) do
      if buf == alternate_buf and buf ~= current_buf then
        table.insert(ordered, { bufnr = buf, original_index = bufnr_to_index[buf] })
        break
      end
    end
  end

  -- List remaining buffers
  for _, buf in ipairs(sorted_buffers) do
    if buf ~= current_buf and buf ~= alternate_buf then
      table.insert(ordered, { bufnr = buf, original_index = bufnr_to_index[buf] })
    end
  end

  return ordered
end

-- Custom entry maker that adds the custom numbering
local function make_buffer_entry(opts)
  opts = opts or {}

  local displayer = entry_display.create({
    separator = " ",
    items = {
      { width = 1 },        -- recent indicators
      { width = 2 },        -- tab number
      { remaining = true }, -- buffer name
    },
  })

  local make_display = function(entry)
    local custom_num = entry.custom_num or "·"
    local indicator = entry.indicator or " "
    local display_name = entry.display_name

    return displayer({
      indicator,
      { custom_num, "TelescopeResultsNumber" },
      display_name,
    })
  end

  return function(entry)
    local bufnr = entry.bufnr
    local bufname = vim.api.nvim_buf_get_name(bufnr)

    -- Display relative path like default buffers picker
    local display_name = vim.fn.fnamemodify(bufname, ":~:.")
    if display_name == "" then
      display_name = "[No Name]"
    end

    -- Get cursor line number for preview positioning
    local lnum = 1
    -- Check if buffer is displayed in a window
    local buf_wins = vim.fn.win_findbuf(bufnr)
    if #buf_wins > 0 then
      -- Get cursor position from the window
      lnum = vim.api.nvim_win_get_cursor(buf_wins[1])[1]
    else
      -- Use last cursor position from the buffer
      local ok, pos = pcall(vim.api.nvim_buf_get_mark, bufnr, '"')
      if ok and pos[1] > 0 then
        lnum = pos[1]
      end
    end

    -- Don't use line 1 for preview positioning
    if lnum <= 1 then
      lnum = 0
    end

    local is_current = vim.api.nvim_get_current_buf() == bufnr
    local is_alternate = vim.fn.bufnr("#") == bufnr
    local indicator = (is_current and "%") or (is_alternate and "#") or " "

    return make_entry.set_default_entry_mt({
      value = bufnr,
      ordinal = entry.custom_num .. " " .. display_name,
      display = make_display,
      bufnr = bufnr,
      filename = bufname,
      lnum = lnum,
      display_name = display_name,
      custom_num = entry.custom_num,
      indicator = indicator,
    }, opts)
  end
end

-- Custom buffer picker
M.show = function(opts)
  opts = opts or {}

  local buffers = get_display_ordered_buffers()
  local entries = {}

  -- Create entries with custom numbering based on original sorted index
  for _, buf_info in ipairs(buffers) do
    local custom_num = "·"
    if buf_info.original_index <= 9 then
      custom_num = string.format("%d", buf_info.original_index)
    end

    table.insert(entries, {
      bufnr = buf_info.bufnr,
      custom_num = custom_num,
      index = buf_info.original_index,
    })
  end

  -- Store entries for quick access by number (maps keymap number to buffer)
  local indexed_entries = {}

  for _, entry in ipairs(entries) do
    if entry.index and entry.index <= 9 then
      indexed_entries[tostring(entry.index)] = entry
    end
  end

  pickers.new(opts, {
    prompt_title = "Buffers",
    finder = finders.new_table({
      results = entries,
      entry_maker = make_buffer_entry(opts),
    }),
    previewer = conf.grep_previewer(opts),
    sorter = conf.generic_sorter(opts),
    initial_mode = "normal",
    selection_strategy = "reset",
    attach_mappings = function(prompt_bufnr, map)
      -- Default action: select buffer
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if selection then
          vim.api.nvim_set_current_buf(selection.bufnr)
        end
      end)

      -- Map delete buffer actions
      local delete_buf = function()
        local selection = action_state.get_selected_entry()
        if selection then
          vim.api.nvim_buf_delete(selection.bufnr, { force = false })
          local current_picker = action_state.get_current_picker(prompt_bufnr)
          current_picker:refresh(finders.new_table({
            results = (function()
              local new_buffers = get_display_ordered_buffers()
              local new_entries = {}
              for _, buf_info in ipairs(new_buffers) do
                local custom_num = "·"
                if buf_info.original_index <= 9 then
                  custom_num = string.format("%d", buf_info.original_index)
                end
                table.insert(new_entries, {
                  bufnr = buf_info.bufnr,
                  custom_num = custom_num,
                  index = buf_info.original_index,
                })
              end
              return new_entries
            end)(),
            entry_maker = make_buffer_entry(opts),
          }), { reset_prompt = false })
        end
      end

      map('i', '<C-d>', delete_buf)
      map('n', 'd', delete_buf)
      map('n', 'x', delete_buf)

      -- Map number keys in normal mode to select the corresponding buffer
      for i = 1, 9 do
        map('n', tostring(i), function()
          local entry = indexed_entries[tostring(i)]
          if entry then
            actions.close(prompt_bufnr)
            vim.api.nvim_set_current_buf(entry.bufnr)
          end
        end)
      end
      return true
    end,
  }):find()
end

return M
