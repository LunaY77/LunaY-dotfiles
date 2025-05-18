return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    -- import lspconfig plugin
    local lspconfig = require("lspconfig")

    -- import mason_lspconfig plugin
    local mason_lspconfig = require("mason-lspconfig")

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap -- for conciseness

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }
        
        -- 跳转到下一个错误或警告
        opts.desc = "跳转到下一个错误或警告"
        keymap.set("n", "ge", vim.diagnostic.goto_next, opts)
        
        -- 将光标移动到上一个方法的声明处
        opts.desc = "将光标移动到上一个方法的声明处"
        keymap.set("n", "gp", vim.lsp.buf.document_highlight, opts)
        
        -- 将光标移动到下一个方法的声明处
        opts.desc = "将光标移动到下一个方法的声明处"
        keymap.set("n", "gn", function()
          if vim.lsp.buf.document_symbol then
            vim.cmd("normal! ]m")
          end
        end, opts)
        
        -- 跳转到父类或接口方法（类似于Go to super method）TODO buggy
        opts.desc = "跳转到父类或接口方法"
        keymap.set("n", "gf", function()
          local win = vim.api.nvim_get_current_win()
          local cursor_before = vim.api.nvim_win_get_cursor(win)

          -- 跳转到定义
          local ok = pcall(vim.lsp.buf.definition)

          -- defer_fn 中延迟执行，判断是否跳转成功
          vim.defer_fn(function()
            local cursor_after = vim.api.nvim_win_get_cursor(win)

            local jumped = (cursor_before[1] ~= cursor_after[1]) or (cursor_before[2] ~= cursor_after[2])

            if jumped then
              -- 已跳转成功，再找引用（调用者）
              if pcall(require, "telescope.builtin") then
                require("telescope.builtin").lsp_references()
              else
                vim.lsp.buf.references()
              end
            else
              -- 没跳转成功，直接查找引用
              if pcall(require, "telescope.builtin") then
                require("telescope.builtin").lsp_references()
              else
                vim.lsp.buf.references()
              end
            end
          end, 100)
        end, opts)
        
        -- 跳转到当前接口或抽象类的实现处
        opts.desc = "跳转到当前接口或抽象类的实现处"
        keymap.set("n", "ga", function()
          if pcall(require, "telescope") then
            vim.cmd("Telescope lsp_implementations")
          else
            vim.lsp.buf.implementation()
          end
        end, opts)
        
        -- 添加显示修复错误提示的快捷键，对应ideavim中的<leader>q
        opts.desc = "显示修复错误提示"
        keymap.set("n", "<leader>q", vim.lsp.buf.code_action, opts) -- 显示错误修复建议
        
        -- 找到所有引用
        opts.desc = "跳转到声明或使用"
        keymap.set("n", "gs", "<cmd>Telescope lsp_references<CR>", opts)
        
        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
        
        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
      end,
    })

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    mason_lspconfig.setup_handlers({
      -- default handler for installed servers
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,
      ["svelte"] = function()
        -- configure svelte server
        lspconfig["svelte"].setup({
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            vim.api.nvim_create_autocmd("BufWritePost", {
              pattern = { "*.js", "*.ts" },
              callback = function(ctx)
                -- Here use ctx.match instead of ctx.file
                client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
              end,
            })
          end,
        })
      end,
      ["graphql"] = function()
        -- configure graphql language server
        lspconfig["graphql"].setup({
          capabilities = capabilities,
          filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
        })
      end,
      ["emmet_ls"] = function()
        -- configure emmet language server
        lspconfig["emmet_ls"].setup({
          capabilities = capabilities,
          filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
        })
      end,
      ["lua_ls"] = function()
        -- configure lua server (with special settings)
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              -- make the language server recognize "vim" global
              diagnostics = {
                globals = { "vim" },
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        })
      end,
    })
  end,
}

