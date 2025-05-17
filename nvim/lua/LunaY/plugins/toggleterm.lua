return {
  "akinsho/toggleterm.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local toggleterm = require("toggleterm")

    toggleterm.setup({
      open_mapping = [[<c-\>]],
      -- 打开新终端后自动进入插入模式
      start_in_insert = true,
      -- 在当前buffer的下方打开新终端
      direction = 'horizontal'
    })
    
    -- 可以在这里添加其他自定义键映射如果需要
    -- local keymap = vim.keymap
    -- keymap.set("n", "<leader>tt", ":ToggleTerm<CR>", { desc = "打开或关闭终端" })
  end,
}
