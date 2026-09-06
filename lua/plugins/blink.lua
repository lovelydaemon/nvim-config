return {
	"saghen/blink.cmp",
	version = "*",
	event = "InsertEnter",
	dependencies = {
		{ "folke/lazydev.nvim", ft = "lua", opts = {} },
	},
	opts = {
		keymap = {
			preset = "none",
			["<C-i>"] = { "show", "hide", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
			["<CR>"] = { "accept", "fallback" },
			["<Tab>"] = {
				function(cmp)
					if cmp.is_visible() and not cmp.snippet_active() then
						return cmp.accept()
					elseif cmp.snippet_active() then
						return cmp.snippet_forward()
					end
				end,
				"fallback",
			},
			["<S-Tab>"] = {
				function(cmp)
					if cmp.snippet_active() then
						return cmp.snippet_backward()
					else
						return cmp.select_prev()
					end
				end,
				"fallback",
			},
			["<C-u>"] = { "scroll_documentation_up", "fallback" },
			["<C-d>"] = { "scroll_documentation_down", "fallback" },
		},
		completion = {
			list = {
				selection = {
					preselect = true,
					auto_insert = false,
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 100,
			},
			menu = {
				draw = {
					columns = {
						{ "label", "label_description", gap = 1 },
					},
				},
			},
		},
		signature = { enabled = true },
		appearance = {
			nerd_font_variant = "mono",
		},
		snippets = {
			preset = "default",
		},
		fuzzy = {
			frecency = { enabled = true },
			use_proximity = true,
		},
		sources = {
			default = { "lazydev", "lsp", "path", "snippets", "buffer" },
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100,
				},
				lsp = { score_offset = 10 },
				snippets = { score_offset = 0 },
			},
		},
	},
}
