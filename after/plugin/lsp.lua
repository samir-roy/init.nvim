-- auto complete
local cmp = require('cmp')
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<tab>'] = cmp.mapping.select_next_item(),
    ['<A-tab>'] = cmp.mapping.select_prev_item(),
  }),
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }),
})

-- configure diagnostic signs
vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "×",
      [vim.diagnostic.severity.WARN] = "▲",
      [vim.diagnostic.severity.HINT] = "•",
      [vim.diagnostic.severity.INFO] = "◦",
    }
  }
})

-- configure lua language server
vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc' },
})

-- configure rust language server
vim.lsp.config('rust_analyzer', {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_markers = { 'Cargo.toml', 'Cargo.lock' },
})

-- configure typescript language server
vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
  root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json' },
  init_options = {
    preferences = {
      importModuleSpecifierPreference = 'non-relative',
      importModuleSpecifierEnding = 'minimal',
    },
  },
})

-- configure graphql language server
vim.lsp.config('graphql', {
  cmd = { 'graphql-lsp', 'server', '-m', 'stream' },
  filetypes = { 'graphql', 'typescriptreact', 'javascriptreact' },
  root_markers = { '.graphqlrc', '.graphql.config.js', 'package.json' },
})

-- configure esLint using traditional lspconfig (couldn't make it work with vim.lsp.config)
-- also lspconfig has been deprecated, so suppress the warning
local original_deprecate = vim.deprecate
vim.deprecate = function() end
require('lspconfig').eslint.setup({})
vim.deprecate = original_deprecate

-- lsp attach callback
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local bufnr = event.buf

    -- extra config for typescript
    if client and client.name == 'ts_ls' then
      -- disable typescript based syntax highlighting and fall back to javascript
      -- client.server_capabilities.semanticTokensProvider = nil

      -- add support for typescript apply code action command
      vim.lsp.commands['_typescript.applyCodeActionCommand'] = function(command)
        local action = command.arguments and command.arguments[1]
        if action and action.fixName then
          vim.lsp.buf.execute_command({
            command = action.fixName,
            arguments = action.fixId and { action.fixId } or {}
          })
        end
      end
    end

    -- load keymaps defined in keymaps.lua
    require('keymaps').set_keymaps_for_lsp(bufnr)
  end,
})

-- enable language servers
vim.lsp.enable('lua_ls')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('ts_ls')
vim.lsp.enable('graphql')
-- eslint is enabled using lspconfig above

-- set up mason for managing language servers
local language_servers = { 'lua_ls', 'rust_analyzer', 'ts_ls', 'eslint', 'graphql' }
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = language_servers,
  automatic_installation = true,
})

-- set up fidget for displaying lsp progress
require('fidget').setup()

-- autocmd to close the quickfix window after selection an option from the list
vim.api.nvim_create_autocmd(
  "FileType",
  {
    pattern = { "qf" },
    command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>]]
  }
)
