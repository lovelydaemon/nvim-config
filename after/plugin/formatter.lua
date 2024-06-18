require("formatter").setup {
  logging = true,
  log_level = vim.log.levels.WARN,
  filetype = {
    typescript = {
      require("formatter.filetypes.typescript").prettierd
    },
    typescriptreact = {
      require("formatter.filetypes.typescriptreact").prettierd
    },
    javascript = {
      require("formatter.filetypes.javascript").prettierd
    },
    javascriptreact = {
      require("formatter.filetypes.javascriptreact").prettierd
    },
    scss = {
      function()
        return {
          exe = 'prettierd',
          args = { vim.api.nvim_buf_get_name(0) },
          stdin = true
        }
      end
    }
  }
}

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
augroup("__formatter__", { clear = true })
autocmd("BufWritePost", {
  group = "__formatter__",
  command = ":FormatWrite"
})
