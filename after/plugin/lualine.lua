local lualine = require 'lualine'

local diff = {
  'diff',
  colored = false,
  symbols = { added = ' ', modified = ' ', removed = ' ' },
}

local filename = {
  'filename',
  symbols = { modified = ' ', readonly = ' ', unnamed = '[No name]' },
  path = 0
}

local diagnostics = {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  sections = { 'error', 'warn' },
  symbols = { error = ' ', warn = ' ' },
  colored = true,
}

lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {},
    lualine_c = { { 'filename', path = 4 } },

    lualine_x = { diagnostics },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { { 'filename', path = 4 } },

    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
