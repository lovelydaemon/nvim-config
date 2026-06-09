return {
	"nvim-telescope/telescope.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{
			"<C-p>",
			function()
				require("telescope.builtin").find_files()
			end,
			desc = "Telescope: Find Files",
		},
		{
			"<leader>pf",
			function()
				require("telescope.builtin").git_status()
			end,
			desc = "Telescope: Git Status",
		},
		{
			"<leader>ps",
			function()
				require("telescope.builtin").live_grep()
			end,
			desc = "Telescope: Live Grep",
		},
	},
	opts = {
		defaults = {
			layout_config = {
				horizontal = {
					width = 0.99,
					height = 0.99,
				},
			},
		},
	},
}
