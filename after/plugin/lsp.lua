local lsp_zero = require('lsp-zero')

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
})

lsp_zero.on_attach(function(client, bufnr)
  -- disable typescript syntax highlighting
  if client.name == 'ts_ls' then
    client.server_capabilities.semanticTokensProvider = nil
  end

  -- configure diagnostics: override sign characters and disable virtual text
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

  -- load keymaps defined in keymaps.lua
  require('keymaps').set_keymaps_for_lsp(bufnr);
end)

local language_servers = { 'lua_ls', 'rust_analyzer', 'ts_ls', 'eslint', 'graphql' }

-- set up language servers
lsp_zero.setup_servers(language_servers)

-- secial configuration for ts_ls
require('lspconfig').ts_ls.setup({
  init_options = {
    preferences = {
      importModuleSpecifierPreference = 'relative',
      importModuleSpecifierEnding = 'minimal',
    },
  }
})

-- set up mason for managing language servers
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = language_servers,
  handlers = {
    lsp_zero.default_setup,
  },
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
