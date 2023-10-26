require('nvim-tree').setup {
  view = {
    side = 'right',
    width = 40,
    centralize_selection = true,
    debounce_delay = 100,
  },
  renderer = {
    indent_width = 1,
    highlight_git = false,
    highlight_diagnostics = true,
    highlight_modified = 'none',
    icons = {
      git_placement = 'after',
      diagnostics_placement = 'after',
      modified_placement = 'before',
      glyphs = {
        modified = '',
        git = {
          unstaged = 'M',
          staged = 'S',
          unmerged = '',
          renamed = 'R',
          untracked = 'U',
          deleted = 'D',
          ignored = 'G',
        }
      },
    }
  },
  git = {
    enable = false,
    show_on_dirs = true,
    show_on_open_dirs = false,
  },
  diagnostics = {
    enable = true,
    show_on_open_dirs = false,
    debounce_delay = 100,
    icons = {
      hint = '',
      info = '',
      warning = '',
      error = '',
    },
  },
  modified = {
    enable = true
  },
  filesystem_watchers = {
    debounce_delay = 100
  }
}
