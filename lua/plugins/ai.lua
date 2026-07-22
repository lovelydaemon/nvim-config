return {
	"milanglacier/minuet-ai.nvim",
	dependencies = { "saghen/blink.cmp" },
	event = "InsertEnter",
	enabled = function() end,
	config = function()
		require("minuet").setup({
			cmp = {
				enable_auto_complete = false,
			},
			blink = {
				enable_auto_complete = false,
			},
			lsp = {
				completion = {
					enable = false,
				},
			},

			provider = "openai_fim_compatible", -- формат openai
			n_completions = 1, -- кол-во отдаваемых дополнений
			context_window = 1024, -- размер контекстного окна
			throttle = 300, -- Задержка в мс перед отправкой запроса в Ollama после остановки ввода
			debounce = 300, -- Задержка в мс на срабатывание

			request_timeout = 3, -- в sec

			provider_options = {
				openai_fim_compatible = {
					api_key = "TERM",
					name = "Ollama",
					end_point = "http://localhost:11434/v1/completions", -- сервер ollama
					model = "qwen2.5-coder:3b-base-q4_K_M", -- модель
					stream = true, -- поддержка стриминга выдачи результата
					optional = {
						max_tokens = 64, -- лимит длины подсказки
						temperature = 0.0, -- влияет на фантазируемость (меньше - ответ строго предсказуемый, больше - для генерации нового)
						top_p = 0.1, -- выбирает из top 10% ответов
						frequency_penalty = 0.0, -- не наказываем за повторяемость слов
						presence_penalty = 0.0, -- не наказываем за отсутствие введения новых тем
					},
				},
			},

			-- Настройки отображения серого текста (как в GitHub Copilot)
			virtualtext = {
				auto_trigger_ft = { "go", "typescript" }, -- форматы файлов на которых будет работать autocomplete
				keymap = {
					accept = "<C-e>",
					accept_line = "<C-f>",
					accept_n_lines = false,
					prev = false,
					next = false,
					dismiss = false,
				},
			},
		})

		-- Фикс Esc
		vim.keymap.set("i", "<Esc>", function()
			pcall(function()
				require("minuet.virtualtext").action_dismiss()
			end)
			return "<Esc>"
		end, { expr = true, silent = true })
	end,
}
