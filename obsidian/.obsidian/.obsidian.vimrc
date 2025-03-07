" jk 退出 insert
inoremap jk <Esc>

" 访问系统剪切板
set clipboard=unnamed

" 将 'j' 和 'k' 映射为在实际行之间移动
nmap j gj
nmap k gk

" 跳转到下一个段落
nmap [ {
nmap ] }

" 跳转到下一个 Heading
exmap nextHeading obcommand quick-snippets-and-navigation:goToNextHeading
exmap prevHeading obcommand quick-snippets-and-navigation:goToPrevHeading
nmap g] :nextHeading<CR>
nmap g[ :prevHeading<CR>


" Surround
exmap surround_wiki surround [[ ]]
exmap surround_double_quotes surround " "
exmap surround_single_quotes surround ' '
exmap surround_brackets surround ( )
exmap surround_square_brackets surround [ ]
exmap surround_curly_brackets surround { }
exmap surround_italic surround * *
exmap surround_bold surround ** **
exmap surround_delete surround ~~ ~~
exmap surround_mark surround == ==
exmap surround_math surround $ $
exmap surround_backtick surround ` `

" NOTE: must use 'map' and not 'nmap'
map [[ :surround_wiki
nunmap s
vunmap s
map s" :surround_double_quotes<CR>
map s' :surround_single_quotes<CR>
map s( :surround_brackets<CR>
map s) :surround_brackets<CR>
map s[ :surround_square_brackets<CR>
map s{ :surround_curly_brackets<CR>
map s} :surround_curly_brackets<CR>
map si :surround_italic<CR>
map sb :surround_bold<CR>
map sd :surround_delete<CR>
map sm :surround_mark<CR>
map s$ :surround_math<CR>
map s` :surround_backtick<CR>

" 需要安装并启用 Zoom 插件 
" Zoom in/out
" zi: 放大
" zo: 缩小
" exmap zoomIn obcommand obsidian-zoom:zoom-in
" exmap zoomOut obcommand obsidian-zoom:zoom-out
" nmap zi :zoomIn<CR>
" nmap zo :zoomOut<CR>

" 需要安装 Quick snippets and navigation
nmap z] :zoomOut<CR>:nextHeading<CR>:zoomIn<CR>
nmap z[ :zoomOut<CR>:prevHeading<CR>:zoomIn<CR>

" 需要安装 Stille 插件 
" Stille Mode
" zs 开关 Focus 模式
exmap toggleStille obcommand obsidian-stille:toggleStille
nmap zs :toggleStille
nmap ,s :toggleStille

" 模拟折叠标题的功能
exmap unfoldall obcommand editor:unfold-all
exmap togglefold obcommand editor:toggle-fold
exmap foldall obcommand editor:fold-all
nmap zx :togglefold<CR>
nmap za :foldall<CR>
nmap zr :unfoldall<CR>

" 使用th和tl实现tab的切换 
exmap tabnext obcommand cycle-through-panes:cycle-through-panes
nmap tl :tabnext<CR>
exmap tabprev obcommand cycle-through-panes:cycle-through-panes-reverse
nmap th :tabprev<CR>

" 实现工作区的横向分割
exmap split-vertical obcommand workspace:split-vertical
nmap sps :split-vertical<CR>
" 实现工作区的纵向分割
exmap split-horizontal obcommand workspace:split-horizontal
nmap spi :split-horizontal<CR>

" 聚焦
exmap focusLeft obcommand editor:focus-left
exmap focusRight obcommand editor:focus-right
exmap focusBottom obcommand editor:focus-bottom
exmap focusTop obcommand editor:focus-top
nmap <C-h> :focusLeft<CR>
nmap <C-l> :focusRight<CR>
nmap <C-j> :focusBottom<CR>
nmap <C-k> :focusTop<CR>
