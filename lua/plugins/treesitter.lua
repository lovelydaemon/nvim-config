return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	lazy = false,
	main = "nvim-treesitter.config",
	opts = {},
	config = function()
		local base_languages = { "lua", "toml", "rust", "go", "markdown", "typescript" }

		require("nvim-treesitter").install(base_languages)

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(ev)
				local lang = vim.treesitter.language.get_lang(ev.match)
				local ts = require("nvim-treesitter")

				if lang and vim.tbl_contains(ts.get_available(), lang) then
					if not vim.tbl_contains(ts.get_installed(), lang) then
						ts.install(lang):wait()
					end

					pcall(vim.treesitter.start, ev.buf)
				end

				local max_filesize = 100 * 1024
				local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(ev.buf))
				if ok and stats and stats.size > max_filesize then
					vim.treesitter.stop(ev.buf)
				end
			end,
		})
	end,
}
