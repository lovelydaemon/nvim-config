return {
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
		opts = {
			servers = {
				lua_ls = {},

				gopls = {
					settings = {
						gopls = {
							semanticTokens = false,
						},
					},
				},

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
			},

			exclude = { "rust_analyzer" },
		},
		config = function(_, opts)
			require("mason").setup()

			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local map = { buffer = event.buf }

					vim.keymap.set("n", "gd", function()
						vim.lsp.buf.definition()
					end, map)
					vim.keymap.set("n", "gh", function()
						vim.lsp.buf.hover()
					end, map)
					vim.keymap.set("n", "]d", function()
						vim.diagnostic.jump({ count = 1, float = true })
					end, map)
					vim.keymap.set("n", "[d", function()
						vim.diagnostic.jump({ count = -1, float = true })
					end, map)
					vim.keymap.set("n", "<leader>qf", function()
						vim.diagnostic.setqflist()
					end, map)
					vim.keymap.set("n", "<leader><C-.>", function()
						vim.lsp.buf.code_action()
					end, map)
					vim.keymap.set("n", "<leader>vrr", function()
						vim.lsp.buf.references()
					end, map)
					vim.keymap.set("n", "<leader>vri", function()
						vim.lsp.buf.implementation()
					end, map)
					vim.keymap.set("n", "<leader>vrn", function()
						vim.lsp.buf.rename()
					end, map)
				end,
			})

			vim.lsp.config("*", {
				capabilities = require("blink.cmp").get_lsp_capabilities({}, true),
			})

			for name, cfg in pairs(opts.servers) do
				vim.lsp.config(name, cfg)
			end

			require("mason-lspconfig").setup({
				ensure_installed = vim.tbl_keys(opts.servers),
				automatic_enable = { exclude = opts.exclude },
			})
		end,
	},
}
