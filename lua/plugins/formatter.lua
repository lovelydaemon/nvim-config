return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  opts = {
    format_on_save = {},
    default_format_opts = {
      lsp_format = 'fallback',
      timeout_ms = 500,
    },
    formatters_by_ft = {
      lua = { "stylua" }
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
      -- typescript = { "prettierd", "prettier", stop_after_first = true },
    }
  },
}
