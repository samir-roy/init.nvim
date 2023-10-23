-- Returns all modified files in the current git repo
-- `2>/dev/null` makes the command fail quietly, so that when we are not
-- in a git repo, the list will be empty
local function gitModified()
  local files = vim.fn.systemlist('git ls-files -m 2>/dev/null')
  return vim.fn.map(files, function(_, val)
    return { line = val, path = val }
  end)
end

-- Returns all untracked files in the current git repo, honoring .gitignore
-- `2>/dev/null` makes the command fail quietly, so that when we are not
-- in a git repo, the list will be empty
local function gitUntracked()
  local files = vim.fn.systemlist('git ls-files -o --exclude-standard 2>/dev/null')
  return vim.fn.map(files, function(_, val)
    return { line = val, path = val }
  end)
end

vim.g.startify_lists = {
  { type = 'dir',        header = { '   MRU ' .. vim.fn.getcwd() } },
  { type = 'sessions',   header = { '   Sessions' } },
  { type = gitModified,  header = { '   Git Modified' } },
  { type = gitUntracked, header = { '   Git Untracked' } },
  { type = 'bookmarks',  header = { '   Bookmarks' } },
  { type = 'commands',   header = { '   Commands' } },
}

vim.g.startify_commands = {
  { x = { '<explore>', 'Ex' } },
}
