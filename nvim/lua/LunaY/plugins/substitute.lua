-- 更好的替换
return {
  "gbprod/substitute.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local substitute = require("substitute")

    substitute.setup()

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "s", substitute.operator, { desc = "在光标位置进行替换" })
    keymap.set("n", "ss", substitute.line, { desc = "替换整行" })
    keymap.set("n", "S", substitute.eol, { desc = "替换到行尾" })
    keymap.set("x", "s", substitute.visual, { desc = "在可视模式下进行替换" })
  end,
}
