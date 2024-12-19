-- 诊断信息管理
return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
  opts = {
    focus = true, -- 聚焦 Trouble 窗口
  },
  cmd = "Trouble", -- 使用 `Trouble` 命令来打开 Trouble 窗口
  keys = {
    { "<leader>xw", "<cmd>Trouble diagnostics toggle<CR>", desc = "打开工作区诊断信息" },
    { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "打开当前文件的诊断信息" },
    { "<leader>xq", "<cmd>Trouble quickfix toggle<CR>", desc = "打开 quickfix 列表" },
    { "<leader>xl", "<cmd>Trouble loclist toggle<CR>", desc = "打开位置列表" },
    { "<leader>xt", "<cmd>Trouble todo toggle<CR>", desc = "在 Trouble 中查看待办事项" },
  },
}
