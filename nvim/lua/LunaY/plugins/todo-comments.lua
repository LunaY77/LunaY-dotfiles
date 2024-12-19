-- todo 注释
-- 使用例:
-- TODO: there is a TODO comment
-- BUG: there is a BUG coment
-- HACK: there is a HACK comment
return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local todo_comments = require("todo-comments")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "]t", function()
      todo_comments.jump_next()
    end, { desc = "下一个 TODO 注释" })

    keymap.set("n", "[t", function()
      todo_comments.jump_prev()
    end, { desc = "前一个 TODO 注释" })

    todo_comments.setup()
  end,
}
