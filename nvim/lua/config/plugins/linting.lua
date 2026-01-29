return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			python = { "pylint" },
			lua = { "luacheck" },
			c = { "clangtidy" },
			cpp = { "clangtidy" },
		}

		-- Auto-lint
		vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
			callback = function()
				lint.try_lint()
			end,
		})

		-- Manual lint with feedback
		vim.keymap.set("n", "<leader>l", function()
			vim.cmd("echo 'Linting...'")

			-- Run lint
			lint.try_lint()

			-- Check results after delay
			vim.defer_fn(function()
				local count = #vim.diagnostic.get(0)

				-- Show results in command line
				if count == 0 then
					vim.cmd("echo '✓ No lint issues found'")
				else
					vim.cmd("echo '⚠️  Found " .. count .. " lint issue(s)'")
				end
			end, 500) -- Wait longer for lint to finish
		end, { desc = "Lint current file" })
	end,
}
