local lsp_zero = require 'lsp-zero'
local lspconfig = require 'lspconfig'
local luasnip = require 'luasnip'
local mason = require 'mason'
local mason_lspconfig = require 'mason-lspconfig'
local cmp = require 'cmp'

mason.setup()
mason_lspconfig.setup({
  ensure_installed = {
    'tsserver',
    'lua_ls',
  },
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      lspconfig.lua_ls.setup(lua_opts)
    end,
    emmet_language_server = function()
      lspconfig.emmet_language_server.setup({
        filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "pug",
          "typescriptreact" },
      })
    end,
    tailwindcss = function()
      lspconfig.tailwindcss.setup({
        autostart = false
      })
    end,
  }
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
  ['<Tab>'] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.confirm({ select = true })
    elseif luasnip.locally_jumpable(1) then
      luasnip.jump(1)
    else
      fallback()
    end
  end, { "i", "s" }),
  ['<S-Tab>'] = cmp.mapping(function(fallback)
    if luasnip.locally_jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end, { "i", "s" }),
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

cmp.setup({
  formatting = {
    format = function(_, vim_item)
      return vim_item
    end
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp_maps,
  sources = cmp.config.sources({
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'path' }
  }, {
    { name = 'buffer' }
  })
})

lsp_zero.set_sign_icons({
  error = '',
  warn = '',
  hint = '',
  info = ''
})

lsp_zero.on_attach(function(_, bufnr)
  local opts = { buffer = bufnr, remap = false }
  vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set('n', 'gh', function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set('n', '<leader><C-.>', function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)
  vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)
end)

lsp_zero.format_on_save({
  servers = {
    ['lua_ls'] = { 'lua' },
    ['svelte'] = { 'svelte' },
    ['cssls'] = { 'css', 'scss' },
    ['tsserver'] = { 'javascript', 'typescript', 'typescriptreact', 'javascriptreact' },
    ['ruby_ls'] = { 'ruby' },
    ['jsonls'] = { 'json' },
    ['volar'] = { 'vue' }
  }
})
