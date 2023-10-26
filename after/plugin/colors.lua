-- SONOKAI THEME CONFIG
vim.g.sonokai_style = 'andromeda'
vim.g.sonokai_better_performance = 1
vim.g.sonokai_transparent_background = 0

-- Custom kanagawa
vim.g.sonokai_colors_override = {
  bg_dim = { '#201E28', '232' },
  bg0 = { '#201E28', '235' },
  bg2 = { '#2C2936', '236' },
  bg_blue = { '#7E9CD8', '110' },
  bg_green = { '#98BB6C', '107' },
  fg = { '#DCD7BA', '250' },
  red = { '#E46876', '203' },
  blue = { '#79AAD0', '110' },
  green = { '#96B369', '107' },
  yellow = { '#E2BD5C', '179' },
  orange = { '#D98C5F', '215' },
  purple = { '#9682B5', '176' },
}

-- Custom term
--vim.g.sonokai_colors_override = {
--  bg_dim = { '#201E28', '232' },
--  bg0 = { '#242530', '235' },
--  bg2 = { '#2C2936', '236' },
--  bg_blue = { '#7E9CD8', '110' },
--  bg_green = { '#98BB6C', '107' },
--  fg = { '#FBFBFB', '250' },
--  red = { '#F95370', '203' },
--  blue = { '#7E9CD8', '110' },
--  green = { '#C3E88D', '107' },
--  yellow = { '#FCCB6B', '179' },
--  orange = { '#FA981F', '215' },
--  purple = { '#C792EA', '176' },
--}
-- setup must be called before loading
vim.cmd("colorscheme sonokai")
