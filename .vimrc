set nocp
set backspace=2
set nocompatible              " 这是必需的 
filetype off                  " 这是必需的 
  
" 你在此设置运行时路径 
set rtp+=~/.vim/bundle/Vundle.vim  
 
" vundle初始化 
call vundle#begin()  
 
" 这应该始终是第一个 
Plugin 'gmarik/Vundle.vim' 

"括号"
Plugin 'jiangmiao/auto-pairs'

Plugin 'akirakyle/vimRunPython'

"一条线
Plugin 'vim-airline/vim-airline'


"vim配色
Plugin 'altercation/vim-colors-solarized'

Plugin 'tomasr/molokai'

"目录树导航
Plugin 'vim-scripts/The-NERD-tree'


Plugin 'Valloric/YouCompleteMe' 
"标签导航
Plugin 'majutsushi/tagbar'

Plugin 'Yggdroot/indentLine'
""缩进指示线


" 该例子来自https://github.com/gmarik/Vundle.vim README 
"Plugin 'tpope/vim-fugitive'  
 
" 来自http://vim-scripts.org/vim/scripts.html的插件 
"Plugin 'L9'  
 
"未托管在GitHub上的Git插件 
"Plugin 'git://git.wincent.com/command-t.git'  
 
" sparkup vim脚本在名为vim的该软件库子目录下。 
" 传递路径，合理设置运行时路径。 
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'} 
 
" 与L9避免名称冲突 
"Plugin 'user/L9', {'name': 'newL9'}  
"每个插件都应该在这一行之前  
call vundle#end()            " required


set nocompatible
"不与 Vi 兼容（采用 Vim 自己的操作命令）

syntax on
"打开语法高亮

set encoding=utf-8
set fenc=utf-8      "编码
set langmenu=zh_CN.UTF-8
language message zh_CN.UTF-8

filetype indent on
"开启文件类型检查和对应缩进规则

set autoindent
"按下回车 缩进保持一致

set nu
"显示行号

set cursorline
"光标行亮

set tabstop=4
"tab 空格长度"

set shiftwidth=4
"缩进长度"

set guifont=Monospace\ 14
"设置字体大小

if has('gui_running')
	set background=dark
	let g:solarized_termcolors=256
    let g:solarized_termtrans=1
    let g:solarized_contrast="normal"
    let g:solarized_visibility="normal"
    colorscheme solarized
else
    
	let g:molokai_original = 0
	colorscheme molokai 
endif

if  has("gui_runing")     " 使用GUI界面时的设置
    set guioptions+=c        " 使用字符提示框
    set guioptions-=m        " 隐藏菜单栏
    "set guioptions-=T        " 隐藏工具栏
    set guioptions-=L        " 隐藏左侧滚动条
    "set guioptions-=r        " 隐藏右侧滚动条
    set guioptions-=b        " 隐藏底部滚动条
    "set showtabline=0       " 隐藏Tab栏
    set cursorline           " 突出显示当前行
endif

autocmd Syntax html,vim inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>

"一键运行"
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!time java %<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
 ""       exec "!time python2.7 %"
 	""	exec "term"
		""	exec "vim"
    "    exec "!time python3.6 %" 
		exec "!time python3.7 %"
    elseif &filetype == 'html'
        exec "!firefox % &"
    elseif &filetype == 'go'
        exec "!go build %<"
        exec "!time go run %"
    elseif &filetype == 'mkd'
        exec "!~/.vim/markdown.pl % > %.html &"
        exec "!firefox %.html &"
    endif
endfunc

""""""""""""""""""""""""""""""”“”“”“自动补全
"自动补全"i
" 寻找全局配置文件
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
" 禁用syntastic来对python检查
""let g:syntastic_ignore_files=[".*\.py$"] 
" 使用ctags生成的tags文件
let g:ycm_collect_identifiers_from_tag_files = 1
" 开启语义补全
" 修改对C语言的补全快捷键，默认是CTRL+space，修改为ALT+;未测出效果
"let g:ycm_key_invoke_completion = '<M-;>'
" 设置转到定义处的快捷键为ALT+G，未测出效果
"nmap <M-g> :YcmCompleter GoToDefinitionElseDeclaration <C-R>=expand("<cword>")<CR><CR> 
"关键字补全
"let g:ycm_seed_identifiers_with_syntax = 1
" 在接受补全后不分裂出一个窗口显示接受的项
set completeopt-=preview
" 让补全行为与一般的IDE一致
set completeopt+=longest,menu
" 不显示开启vim时检查ycm_extra_conf文件的信息
let g:ycm_confirm_extra_conf=0
" 每次重新生成匹配项，禁止缓存匹配项
let g:ycm_cache_omnifunc=0
" 在注释中也可以补全
let g:ycm_complete_in_comments=1
" 输入第一个字符就开始补全
let g:ycm_min_num_of_chars_for_completion=1
" 错误标识符
let g:ycm_error_symbol='>>'
" 警告标识符
let g:ycm_warning_symbol='>*'
" 不查询ultisnips提供的代码模板补全，如果需要，设置成1即可
" let g:ycm_use_ultisnips_completer=0
let g:ycm_python_binary_path = '/usr/bin/python3'  "jedi模块所在python解释器路径"
let g:ycm_seed_identifiers_with_syntax = 1  "开启使用语言的一些关键字查询"
let g:ycm_autoclose_preview_window_after_completion=1 "补全后自动关闭预览窗口"

let g:ycm_python_interpreter_path = '/usr/bin/python3'

let g:ycm_server_python_interpreter = ''
let g:ycm_semantic_triggers = {
            \ 'c,python': ['re!\w{2}'],
            \ }
"let g:ycm_python_sys_path = []
"let g:ycm_extra_conf_vim_data = [
 " \  'g:ycm_python_interpreter_path',
  "\  'g:ycm_python_sys_path'
  "\]
""let g:ycm_global_ycm_extra_conf = '~/global_extra_conf.py'
""if &filetype =='c'
""	let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py' 
""elseif &filetype =='py'
""	let g:ycm_global_ycm_extra_conf = '~/Pictures/.ycm_extra_conf.py'
""endif

let g:ycm_max_num_candidates = 50

autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"离开插入模式后自动关闭预览窗口
"""""""""""""""""""""""""""""""""""""""""""目录数导航
"The NERD tree
"F3触发，设置宽度为30,显示书签
map <F3> :NERDTreeToggle<CR>
let NERDTreeWinSize = 30
let NERDTreeShowBookmarks = 1
"高亮当前行
let NERDTreeHighlightCursorline = 1
"从NERDTree打开文件后自动关闭NERDTree
let NERDTreeQuitOnOpen = 1
"显示隐藏文件
let g:NERDTreeShowHidden = 1
"忽略特定文件和目录
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$',
            \ '\.o$', '\.so$', '\.egg$', '^\.git$', '__pycache__', '\.DS_Store' ]
"显示行号
"let NERDTreeShowLineNumbers = 1
"let NERDTreeAutoCenter = 1
"自动打开NERDTree
"autocmd vimenter * NERDTree



"""""""""""""""""""""""""""""""""""""""""""”标签导航
"tagbar
"F9触发，设置宽度为30
let g:tagbar_width = 30
nmap <F8> :TagbarToggle<CR>
"开启自动预览(随着光标在标签上的移动，顶部会出现一个实时的预览窗口)
let g:tagbar_autopreview = 1
"关闭排序,即按标签本身在文件中的位置排序
let g:tagbar_sort = 0
