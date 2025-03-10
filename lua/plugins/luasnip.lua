return {
  "L3MON4D3/LuaSnip",
  -- follow latest release.
  version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  -- install jsregexp (optional!).
  build = "make install_jsregexp",
  config = function()
    local luasnip = require('luasnip.loaders.from_vscode')
    luasnip.lazy_load({ paths = { '~/.config/nvim/snippets' } })
  end
}
