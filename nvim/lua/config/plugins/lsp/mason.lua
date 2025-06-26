return {
    "williamboman/mason.nvim",
    lazy = false,
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp", -- Fixed from saghen/cmp-nvim-lsp
        "stevearc/conform.nvim",
    },
    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local mason_tool_installer = require("mason-tool-installer")

        -- Mason setup
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "→",
                    package_uninstalled = "x",
                },
            },
        })

        -- Mason-lspconfig setup
        mason_lspconfig.setup({
            ensure_installed = {
                "pyright",    -- Python
                "lua_ls",     -- Lua
                "jdtls",      -- Java
                "clangd",     -- C/C++
                "omnisharp",  -- C#
            },
            automatic_installation = true,
        })

        -- Mason-tool-installer setup
        mason_tool_installer.setup({
            ensure_installed = {
                "ruff",              -- Python
                "stylua",            -- Lua
                "google-java-format", -- Java
                "clang-format",      -- C/C++
                "csharpier",         -- C#
            },
            auto_update = true,
            run_on_start = true,
        })
    end,
}
