return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		treesitter.setup({
			-- Auto-install missing parsers
			auto_install = true,

			highlight = {
				enable = true,
				-- Disable for large files to prevent hangs
				disable = function(lang, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
			},

			indent = {
				enable = true,
				disable = { "python", "yaml" }, -- These often work better with dedicated plugins
			},

			-- Only specify languages you actually use
			ensure_installed = {
				"c",
				"cpp",
				"go",
				"java",
				"rust",
				"python",
				"lua",
				"bash",
				"javascript",
				"typescript",
				"html",
				"css",
				"json",
				"yaml",
				"markdown",
				"vim",
				"vimdoc",
			},

			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					node_decremental = "<S-C-space>",
				},
			},

			additional_vim_regex_highlighting = false,
		})
	end,
}
