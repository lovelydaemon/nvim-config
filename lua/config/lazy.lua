-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Options
vim.opt.nu = true
vim.opt.relativenumber = false

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

-- Keys

vim.keymap.set('n', '<leader>e', ':NvimTreeFindFileToggle <CR>')
--disable default
vim.keymap.set('n', '<Space>', '<nop>')
vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('n', 'q', '<nop>')

--Esc from insert mode by jk buttons
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('i', 'JK', '<Esc>')


--move selected lines up and down
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")

--scroll doc and hold cursor in the middle of the screen
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

--best search using / and keep cursor in the middle
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- windows
vim.keymap.set('n', '<leader>wo', ':vsplit<CR>')
vim.keymap.set('n', '<leader>ww', ':wincmd w<CR>')
vim.keymap.set('n', '<leader>wh', ':wincmd h<CR>')
vim.keymap.set('n', '<leader>wj', ':wincmd j<CR>')
vim.keymap.set('n', '<leader>wk', ':wincmd k<CR>')
vim.keymap.set('n', '<leader>wl', ':wincmd l<CR>')

-- vsplit and goto definition
vim.keymap.set('n', '<leader>gd', ':vsplit | :wincmd w | lua vim.lsp.buf.definition()<CR>')

--visual
vim.keymap.set('v', '<leader>\'', 'c\'<Esc>pa\'<Esc>')
vim.keymap.set('v', '<leader>"', 'c"<Esc>pa"<Esc>')
vim.keymap.set('v', '<leader>[', 'c[<Esc>pa]<Esc>')
vim.keymap.set('v', '<leader>{', 'c{<Esc>pa}<Esc>')
--Git
vim.keymap.set('n', ']c', ':Gitsigns next_hunk<CR>')
vim.keymap.set('n', '[c', ':Gitsigns prev_hunk<CR>')

-- replace all
vim.keymap.set('n', '<leader>ra', '* :%s/')

require("lazy").setup("plugins", {
  change_detection = {
    notify = false,
  },
})
