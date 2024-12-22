vim.g.mapleader = " " 

local keymap = vim.keymap -- for conciseness / 变量名替换

keymap.set("i", "jk", "<ESC>", { desc = "使用 jk 退出 insert 模式"})

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "消除搜索高光" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "递增数字" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "递减数字" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "左右分割屏幕" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "上下分割屏幕" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "使分割窗口大小相等" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "关闭当前分割窗口" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "打开新标签页" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "关闭当前标签页" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "前往下一个标签页" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "前往上一个标签页" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "将当前缓冲移动到新标签页" }) --  move current buffer to new tab

vim.keymap.set("n", "<leader>aa", function()
  -- 保存光标位置
  local save_cursor = vim.fn.getpos(".")
  -- 执行全选并复制
  vim.cmd("normal! ggvGy")
  -- 恢复光标位置
  vim.fn.setpos(".", save_cursor)
end, { desc = "全选并复制，但光标保持在原位置" })

-- 解绑 Ctrl+d 和 Ctrl+u
-- vim.keymap.set("n", "<C-d>", "<Nop>", { desc = "解除 Ctrl+d 的翻页绑定" })
-- vim.keymap.set("n", "<C-u>", "<Nop>", { desc = "解除 Ctrl+u 的翻页绑定" })

-- 绑定 <leader>v 和 <leader>b
vim.keymap.set("n", "<leader>v", "<C-d>", { desc = "向下翻页" })
vim.keymap.set("n", "<leader>b", "<C-u>", { desc = "向上翻页" })
