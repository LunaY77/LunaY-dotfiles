-- lsp

return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        -- "tsserver",         -- TypeScript/JavaScript LSP
        "html",             -- HTML LSP
        "cssls",            -- CSS LSP
        "tailwindcss",      -- Tailwind CSS LSP
        -- "svelte",           -- Svelte LSP
        -- "lua_ls",           -- Lua LSP
        -- "graphql",          -- GraphQL LSP
        -- "emmet_ls",         -- Emmet LSP
        -- "prismals",         -- Prisma LSP
        -- "python-lsp-server",          -- Python LSP
        "jdtls",            -- Java LSP (Java Development Tools)
        -- "dockerls",         -- Docker LSP
        -- "dockerfile_ls",    -- Dockerfile LSP
        -- "gopls",            -- Go LSP
        -- "clangd",           -- C/C++ LSP  
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier", -- prettier formatter
        "isort", -- python formatter
        "black", -- python formatter
        "pylint", -- python linter
        "eslint_d", -- JavaScript linter  
        "checkstyle", -- Java linter
      },
    })
  end,
}
