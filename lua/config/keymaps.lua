-- Disable default
vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('n', 'q', '<nop>')

-- Esc from insert mode by jk buttons
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('i', 'JK', '<Esc>')


-- Move selected lines up and down
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { silent = true })

-- Scroll doc and hold cursor in the middle of the screen
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Best search using / and keep cursor in the middle
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Windows
vim.keymap.set('n', '<leader>wo', '<cmd>vsplit<CR>', { silent = true })
vim.keymap.set('n', '<leader>wh', '<cmd>wincmd h<CR>', { silent = true })
vim.keymap.set('n', '<leader>wj', '<cmd>wincmd j<CR>', { silent = true })
vim.keymap.set('n', '<leader>wk', '<cmd>wincmd k<CR>', { silent = true })
vim.keymap.set('n', '<leader>wl', '<cmd>wincmd l<CR>', { silent = true })

-- Vsplit and goto definition
vim.keymap.set('n', '<leader>gd', function()
  vim.cmd('vsplit')
  vim.cmd('wincmd w')
  vim.lsp.buf.definition()
end)

-- Visual
vim.keymap.set('v', "<leader>'", "x<Esc>i'<C-r>\"'<Esc>")
vim.keymap.set('v', '<leader>"', 'x<Esc>i"<C-r>""<Esc>')
vim.keymap.set('v', '<leader>[', 'x<Esc>i[<C-r>"]<Esc>')
vim.keymap.set('v', '<leader>{', 'x<Esc>i{<C-r>"}<Esc>')

-- Replace all
vim.keymap.set('n', '<leader>ra', ':%s/\\<<C-r><C-w>\\>/')

-- Curl
--vim.keymap.set('n', '<leader>bb', 'vip:!zsh<CR>', { silent = true })
--vim.keymap.set('n', '<leader>bj', 'vip:!zsh | jq<CR>', { silent = true })
--vim.keymap.set('n', '<leader>jj', 'vip:!jq<CR>', { silent = true })
