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

-- curl
vim.keymap.set('n', '<leader>bb', 'vip:!zsh<CR>')
vim.keymap.set('n', '<leader>bj', 'vip:!zsh | jq<CR>')
vim.keymap.set('n', '<leader>jj', 'vip:!jq<CR>')
