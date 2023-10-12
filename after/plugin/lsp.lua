local lsp_zero = require('lsp-zero')

-- auto complete
local cmp = require('cmp')
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    -- use tab and shift-tab to cycle through items
    ['<tab>'] = cmp.mapping.select_next_item(),
    ['<S-tab>'] = cmp.mapping.select_prev_item(),
  })
})

---@diagnostic disable-next-line: unused-local
lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings to learn the available actions
  local opts = { buffer = bufnr, remap = false }
  lsp_zero.default_keymaps(opts)

  -- disable typescript syntax highlighting
  if client.name == 'tsserver' then
    client.server_capabilities.semanticTokensProvider = nil
  end

  -- show hover info
  vim.keymap.set('n', '<leader>i', function() vim.lsp.buf.hover() end, opts)
  -- list available code actions
  vim.keymap.set('n', '<leader>a', function() vim.lsp.buf.code_action() end, opts)
  -- go to definition - same as gd
  vim.keymap.set('n', '<leader>g', function() vim.lsp.buf.definition() end, opts)
  -- open diagnostics float
  vim.keymap.set('n', '<leader>d', function() vim.diagnostic.open_float() end, opts)

  -- format using lsp
  vim.keymap.set({ 'n', 'x' }, '<leader>.', function()
    vim.lsp.buf.format({
      async = false,
      timeout_ms = 3000,
    })
  end, opts)

  -- override sign characters in sign column
  local signs = { Error = "⛞", Warn = "⛨", Hint = "✴", Info = "ℹ" }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  -- don't show virtual text on each line
  vim.diagnostic.config({ virtual_text = false })
  -- instead open the float when the cursor is moved to a line with diagnostics
  -- vim.api.nvim_exec([[
  --   augroup LspCursorFloatAutocmd
  --     autocmd!
  --     autocmd CursorMoved * lua vim.diagnostic.open_float()
  --   augroup END
  -- ]], false)
end)

-- configure language servers
require('lspconfig').lua_ls.setup({})
require('lspconfig').rust_analyzer.setup({})
require('lspconfig').eslint.setup({})
require('lspconfig').tsserver.setup({})

-- set up language servers
lsp_zero.setup_servers({ 'lua_ls', 'rust_analyzer', 'tsserver', 'eslint' })

-- set up mason for managing language servers
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { 'lua_ls', 'rust_analyzer', 'tsserver', 'eslint' },
  handlers = {
    lsp_zero.default_setup,
  },
})
