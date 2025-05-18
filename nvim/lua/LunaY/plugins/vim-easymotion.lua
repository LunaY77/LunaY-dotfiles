-- 快速移动插件
return {
  "easymotion/vim-easymotion",
  config = function()
    -- 设置跳转标签为小写字母（更容易按）
    vim.g.EasyMotion_keys = 'asdghklqwertyuiopzxcvbnmfj'
    
    -- 美化高亮颜色配置
    vim.cmd([[
      " 目标标签颜色（深蓝色背景，亮黄色前景 - 更现代的配色）
      hi EasyMotionTarget guifg=#FFEA00 guibg=#1E3A8A gui=bold ctermfg=226 ctermbg=25 cterm=bold
      
      " 次要目标标签颜色（渐变配色）
      hi EasyMotionTarget2First guifg=#F0F0F0 guibg=#7952B3 gui=bold ctermfg=255 ctermbg=97 cterm=bold
      hi EasyMotionTarget2Second guifg=#FFFFFF guibg=#34568B gui=bold ctermfg=15 ctermbg=25 cterm=bold
      
      " 阴影部分的颜色（柔和的灰色）
      hi EasyMotionShade guifg=#777777 guibg=NONE gui=NONE ctermfg=242 ctermbg=NONE cterm=NONE
      
      " 匹配的字符颜色（蓝色背景，白色前景）
      hi EasyMotionMoveHL guifg=#ffffff guibg=#4169E1 gui=bold ctermfg=15 ctermbg=69 cterm=bold
      
      " 光标行颜色
      hi EasyMotionIncCursor guifg=#000000 guibg=#00FF00 gui=bold ctermfg=0 ctermbg=46 cterm=bold
    ]])
    
    -- 映射常用的 easymotion 命令
    vim.cmd([[
      " 双向搜索字符，支持输入多个字符直到回车
      map <leader><leader>s <Plug>(easymotion-sn)
      
      " 向下搜索并跳转
      map <leader><leader>j <Plug>(easymotion-j)
      
      " 向上搜索并跳转
      map <leader><leader>k <Plug>(easymotion-k)
      
      " 双向搜索单词并跳转
      map <leader><leader>w <Plug>(easymotion-w)
      
      " 双向搜索行并跳转
      map <leader><leader>L <Plug>(easymotion-bd-jk)
    ]])
  end,
} 