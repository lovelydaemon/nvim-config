return {
  "nvim-telescope/telescope.nvim",
  tag = '0.1.8',
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  config = function()
    local telescope = require('telescope')

    telescope.setup({
      defaults = {
        layout_config = {
          horizontal = {
            width = 0.99,
            height = 0.99
          },
        },
      }
    })

    local builtin = require 'telescope.builtin'

    vim.keymap.set('n', '<leader>pf', builtin.git_status, {})
    vim.keymap.set('n', '<C-p>', builtin.find_files, {})
    vim.keymap.set('n', '<leader>ps', function()
      builtin.grep_string({ search = vim.fn.input('Grep > ') });
    end)
  end,
}
