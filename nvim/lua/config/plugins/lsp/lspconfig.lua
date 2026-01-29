return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		-- Capabilities for autocomplete
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Keybinds when LSP attaches
		local on_attach = function(client, bufnr)
			local opts = { buffer = bufnr, silent = true }

			-- Navigation
			vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
			vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
			vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
			vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

			-- Actions
			vim.keymap.set({ "n", "v" }, "<leader>vca", vim.lsp.buf.code_action, opts)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

			-- Diagnostics
			vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
			vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

			-- Help
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
			vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
		end

		-- Setup servers
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "lua", "python", "java", "c", "cpp", "cs" },
			callback = function(args)
				local bufnr = args.buf
				local ft = vim.bo[bufnr].filetype

				-- Check if LSP already attached
				local clients = vim.lsp.get_clients({ bufnr = bufnr })
				if #clients > 0 then
					return
				end

				-- Common config
				local config = {
					capabilities = capabilities,
					on_attach = on_attach,
					bufnr = bufnr, -- Attach to current buffer
				}

				if ft == "lua" then
					config.name = "lua_ls"
					config.cmd = { "lua-language-server" }
					config.settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
							completion = { callSnippet = "Replace" },
							workspace = { library = vim.api.nvim_get_runtime_file("", true) },
							telemetry = { enable = false },
						},
					}
					config.root_dir =
						vim.fs.dirname(vim.fs.find({ ".git", ".luarc.json", ".stylua.toml" }, { upward = true })[1])
				elseif ft == "python" then
					config.name = "pyright"
					config.cmd = { "pyright-langserver", "--stdio" }
					config.root_dir =
						vim.fs.dirname(vim.fs.find({ ".git", "pyproject.toml", "setup.py" }, { upward = true })[1])
				end

				-- Start LSP
				vim.lsp.start(config)
			end,
		})

		-- Diagnostic visuals
		local signs = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
			[vim.diagnostic.severity.INFO] = " ",
		}

		vim.diagnostic.config({
			signs = { text = signs },
			virtual_text = true,
			underline = true,
			update_in_insert = false,
		})
	end,
}
