return {
	{
		"sadhen/blink.cmp",
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
	},

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "saghen/blink.cmp" },
		},
		init = function()
			vim.diagnostic.config({
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.HINT] = "",
						[vim.diagnostic.severity.INFO] = "",
					},
				},
				underline = true,
				virtual_text = false,
			})
		end,
		config = function()
			require("mason").setup()

			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local opts = { buffer = event.buf }

					vim.keymap.set("n", "gd", function()
						vim.lsp.buf.definition()
					end, opts)
					vim.keymap.set("n", "gh", function()
						vim.lsp.buf.hover()
					end, opts)
					vim.keymap.set("n", "]d", function()
						vim.diagnostic.jump({ count = 1, float = true })
					end, opts)
					vim.keymap.set("n", "[d", function()
						vim.diagnostic.jump({ count = -1, float = true })
					end, opts)
					vim.keymap.set("n", "<leader><C-.>", function()
						vim.lsp.buf.code_action()
					end, opts)
					vim.keymap.set("n", "<leader>vrr", function()
						vim.lsp.buf.references()
					end, opts)
					vim.keymap.set("n", "<leader>vri", function()
						vim.lsp.buf.implementation()
					end, opts)
					vim.keymap.set("n", "<leader>vrn", function()
						vim.lsp.buf.rename()
					end, opts)
				end,
			})

			local servers = {
				html = { filetypes = { "html", "handlebars" } },
				emmet_language_server = { filetypes = { "html", "handlebars" } },
				lua_ls = {},
				yamlls = {
					settings = {
						yaml = {
							schemaStore = {
								enable = true,
								url = "",
							},

							schemas = {
								["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
									"docker-compose*.yml",
									"docker-compose*.yaml",
									"compose*.yml",
									"compose*.yaml",
								},

								["https://spec.openapis.org/oas/3.0/schema/2024-10-18"] = {
									"openapi*.yml",
									"openapi*.yaml",
									"swagger*.yml",
									"swagger*.yaml",
									"*api*.yml",
									"*api*.yaml",
								},
							},
						},
					},
				},
			}

			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls" },
				handlers = {
					function(server_name)
						local server_opts = servers[server_name] or {}

						vim.lsp.config(server_name, server_opts)
						vim.lsp.enable(server_name)
					end,
				},
			})
		end,
	},
}
