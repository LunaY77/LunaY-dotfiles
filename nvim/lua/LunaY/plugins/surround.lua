-- 快速操作包围字符
-- 使用例
-- ys{ : 添加 {}
-- Visual mode 下选中后，输入 S" : 选中的文本包围在 ""
-- cs"< : 将双引号替换为 <
-- ds" : 将双引号删除
return {
  "kylechui/nvim-surround",
  event = { "BufReadPre", "BufNewFile" },
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  config = true,
}
