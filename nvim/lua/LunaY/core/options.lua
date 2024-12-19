vim.cmd("let g:netrw_liststyle = 3") -- 将文件浏览替换为 tree 格式

local opt = vim.opt

opt.relativenumber = true -- 显示 relativenumber 在左侧
opt.number = true -- 显示 当前行

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs / tab 更改为 2 空格
opt.shiftwidth = 2 -- 2 spaces for indent width / 缩进 更改为 2 空格
opt.expandtab = true -- expand tab to spaces  
opt.autoindent = true -- copy indent from current line when starting new one / 在新的一行开始时复制上一行的缩进

-- line wrapping
opt.wrap = false -- disable line wrapping / 禁用自动换行、折行

-- search settings
opt.ignorecase = true -- ignore case when searching / 在搜索时忽略大小写
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive / 如果搜索时大小写同时存在，那么启用大小写敏感

-- cursor line
opt.cursorline = true -- highlight the current cursor line / 高亮当前行

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true -- 终端可以显示 24 位颜色
opt.background = "dark" -- colorschemes that can be light or dark will be made dark / 设置 Neovim 的背景为 “dark”（暗色模式）
opt.signcolumn = "yes" -- show sign column so that text doesn't shift / 启用标志列（sign column），并确保标志列始终可见。标志列通常用于显示行号旁边的标志（如 LSP 错误、警告、git 状态等）

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position
--设置 backspace 选项，允许在以下位置使用退格键：
--	•	indent：允许在缩进位置使用退格键。
--	•	eol：允许在行尾位置使用退格键。
--	•	start：允许在插入模式下的起始位置使用退格键。

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register / 与操作系统的剪贴板共享数据

-- split windows
opt.splitright = true -- split vertical window to the right / 垂直分割窗口时，新窗口会出现在当前窗口的右侧
opt.splitbelow = true -- split horizontal window to the bottom / 水平分割窗口时，新窗口会出现在当前窗口的下方
