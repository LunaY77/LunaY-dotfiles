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
