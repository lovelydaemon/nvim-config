local lsp = require 'lsp-zero'
local cmp = require 'cmp'
local luasnip = require 'luasnip'


lsp.preset('recommended')

lsp.ensure_installed({
  'tsserver',
  'lua_ls',
})

local cmp_maps = {
  ['<C-i>'] = function()
    if cmp.visible() then
      cmp.close()
    else
      cmp.complete()
    end
  end,
  ['<C-j>'] = function()
    if cmp.visible() then
      cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
    end
  end,
  ['<C-k>'] = function()
    if cmp.visible() then
      cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
    end
  end,
  ['<Tab>'] = function(fallback)
    if cmp.visible() then
      cmp.confirm({ select = true })
    else
      fallback()
    end
  end,
  ['<CR>'] = function(fallback)
    if cmp.visible() then
      cmp.confirm({ select = true })
    else
      fallback()
    end
  end,
  ['<C-d>'] = function()
    if cmp.visible() then
      cmp.scroll_docs(4)
    end
  end,
  ['<C-u>'] = function()
    if cmp.visible() then
      cmp.scroll_docs(-4)
    end
  end,
  ['<C-e>'] = function() end,
  ['<C-n>'] = function() end,
  ['<C-p>'] = function() end,
  ['<C-y>'] = function() end,
}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp_maps
}


lsp.setup_nvim_cmp({
  mapping = cmp_maps,
  formatting = {
    format = function(_, vim_item)
      return vim_item
    end
  },
  sources = cmp.config.sources({
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'path' }
  }, {
    { name = 'buffer' }
  })
})

lsp.set_sign_icons({
  error = '',
  warn = '',
  hint = '',
  info = ''
})

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  -- goto definition
  vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)

  -- show info
  vim.keymap.set('n', 'gh', function() vim.lsp.buf.hover() end, opts)


  --vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
  --vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)

  -- goto next warn/error
  vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, opts)

  -- goto prev warn/error
  vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, opts)

  -- light bulb aka cmd+
  vim.keymap.set('n', '<leader><C-.>', function() vim.lsp.buf.code_action() end, opts)

  vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)
  vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)
  --vim.keymap.set('i', '<C-i>', function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.format_on_save({
  servers = {
    ['lua_ls'] = { 'lua' },
    ['svelte'] = { 'svelte' },
    ['cssls'] = { 'css', 'scss' },
    ['tsserver'] = { 'javascript', 'typescript' },
    ['tailwindcss'] = { 'css' },
  }
})

lsp.setup()
