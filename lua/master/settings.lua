vim.opt.nu = true
vim.opt.rnu = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 10
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

--vim.opt.colorcolumn = '80'

vim.opt.mouse = ''
vim.opt.showmode = true

vim.opt.clipboard = 'unnamedplus'

vim.diagnostic.config {
  virtual_text = false
}

vim.opt.fillchars = {
  eob = ' '
}

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
