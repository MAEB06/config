return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                python = { "black" },
                lua = { "stylua" },
                c = { "clang_format" },
                cpp = { "clang_format" },
                cs = { "csharpier" },
                java = { "google_java_format" },
            },
            format_on_save = {
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            },
        })

        -- Configure individual formatters
        conform.formatters.black = {
            command = "black",
            args = { "--quiet", "-" },
            stdin = true,
        }

        conform.formatters.stylua = {
            command = "stylua",
            args = { "--search-parent-directories", "--stdin-filepath", "$FILENAME", "-" },
            stdin = true,
        }

        conform.formatters.clang_format = {
            command = "clang-format",
            args = { "--assume-filename", "$FILENAME" },
            stdin = true,
        }

        conform.formatters.csharpier = {
            command = "csharpier",
            args = { "--write-stdout", "$FILENAME" },
            stdin = false,
        }

        conform.formatters.google_java_format = {
            command = "google-java-format",
            args = { "-" },
            stdin = true,
        }
    end,
}
