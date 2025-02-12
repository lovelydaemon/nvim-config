return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = true,
  },

  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
      { 'saadparwaiz1/cmp_luasnip' },
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      cmp.setup({
        formatting = {
          format = function(_, vim_item)
            return vim_item
          end
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end
        },
        mapping = cmp.mapping.preset.insert({
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
            if cmp.visible() and not luasnip.in_snippet() then
              cmp.confirm({ select = true })
            elseif luasnip.jumpable(1) and luasnip.in_snippet() then
              luasnip.jump(1)
              if not luasnip.jumpable(1) then
                luasnip.unlink_current()
              end
            else
              fallback()
            end
          end, { "i", "s" }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) and luasnip.in_snippet() then
              luasnip.jump(-1)
              if not luasnip.jumpable(-1) then
                luasnip.unlink_current()
              end
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
        }),
        sources = cmp.config.sources({
          { name = 'luasnip' },
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'path' },
        }, {
          { name = 'buffer' }
        }),
      })
    end
  },

  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

    },
    init = function()
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.HINT] = '',
            [vim.diagnostic.severity.INFO] = '',
          }
        },
        underline = false
      })
    end,
    config = function()
      local lsp_defaults = require('lspconfig').util.default_config
      local cmp_nvim_lsp = require('cmp_nvim_lsp')

      lsp_defaults.capabilities = vim.tbl_deep_extend(
        'force',
        lsp_defaults.capabilities,
        cmp_nvim_lsp.default_capabilities()
      )

      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local opts = { buffer = event.buf }

          vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
          vim.keymap.set('n', 'gh', function() vim.lsp.buf.hover() end, opts)
          vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, opts)
          vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, opts)
          vim.keymap.set('n', '<leader><C-.>', function() vim.lsp.buf.code_action() end, opts)
          vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)
          vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)
        end
      })

      local mason_lspconfig = require('mason-lspconfig')
      local lspconfig = require('lspconfig')

      mason_lspconfig.setup({
        ensure_installed = {
          'ts_ls',
          'lua_ls',
          'eslint@4.8.0'
        },
        handlers = {
          function(server_name)
            lspconfig[server_name].setup({})
          end,
          lua_ls = function()
            lspconfig.lua_ls.setup({
              settings = {
                Lua = {
                  telemetry = {
                    enable = false
                  },
                },
              },
              on_init = function(client)
                local join = vim.fs.joinpath
                local path = client.workspace_folders[1].name

                -- Don't do anything if there is project local config
                if vim.uv.fs_stat(join(path, '.luarc.json'))
                    or vim.uv.fs_stat(join(path, '.luarc.jsonc'))
                then
                  return
                end

                -- Apply neovim specific settings
                local runtime_path = vim.split(package.path, ';')
                table.insert(runtime_path, join('lua', '?.lua'))
                table.insert(runtime_path, join('lua', '?', 'init.lua'))

                local nvim_settings = {
                  runtime = {
                    version = 'LuaJIT',
                    path = runtime_path
                  },
                  diagnostics = {
                    -- Get the language server to recognize the 'vim' global
                    globals = { 'vim' }
                  },
                  workspace = {
                    checkThirdParty = false,
                    library = {
                      -- Make the server aware of Neovim runtime files
                      vim.env.VIMRUNTIME,
                      vim.fn.stdpath('config')
                    }
                  }
                }

                client.config.settings.Lua = vim.tbl_deep_extend(
                  'force',
                  client.config.settings.Lua,
                  nvim_settings
                )
              end
            })
          end
        }
      })
    end
  },

}
