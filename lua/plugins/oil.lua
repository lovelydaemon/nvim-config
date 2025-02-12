return {
  'stevearc/oil.nvim',
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
  },
  lazy = false,
  config = function()
    local oil = require('oil')

    vim.keymap.set('n', '<leader>e', ':vsplit | :wincmd w | :Oil<cr>', {})

    oil.setup({
      view_options = {
        show_hidden = true,
      },
      use_default_keymaps = false,
      keymaps = {
        ["g?"] = { "actions.show_help", mode = "n" },
        ["<CR>"] = "actions.select",
        ["<C-v>"] = { "actions.select", opts = { vertical = true } },
        ["<C-l>"] = "actions.refresh",
        ["gs"] = { "actions.change_sort", mode = "n" },
        ["gx"] = "actions.open_external",
        ["g."] = { "actions.toggle_hidden", mode = "n" },
      }
    })
  end
}
