local M = {}

M.init = function()
  -- copy relative path of current buffer
  vim.api.nvim_create_user_command('CopyRelPath', function()
    local path = vim.fn.expand('%:.')
    vim.fn.setreg('+', path)
    vim.notify('Copied: ' .. path)
  end, {})

  -- format using dprint
  vim.api.nvim_create_user_command('F', function()
    vim.cmd('write')
    vim.cmd('silent! !npx dprint fmt %')
  end, {})

  -- format json buffer or selection
  vim.api.nvim_create_user_command('FormatJSON', function(opts)
    local start_line = opts.line1 - 1
    local end_line = opts.line2
    local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line, false)
    local content = table.concat(lines, '\n')

    local ok, _ = pcall(vim.fn.json_decode, content)
    if not ok then
      vim.notify('Not valid JSON', vim.log.levels.ERROR)
      return
    end

    local formatted = vim.fn.system('jq .', content)
    if vim.v.shell_error ~= 0 then
      vim.notify('Failed to format JSON', vim.log.levels.ERROR)
      return
    end

    local formatted_lines = vim.split(formatted, '\n', { plain = true })
    if formatted_lines[#formatted_lines] == '' then
      table.remove(formatted_lines)
    end

    vim.api.nvim_buf_set_lines(0, start_line, end_line, false, formatted_lines)
    vim.notify('JSON formatted')
  end, { range = '%' })
end

return M
