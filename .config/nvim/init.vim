call plug#begin(stdpath('data') . '/plugged')
    Plug 'scrooloose/nerdcommenter'
    Plug 'preservim/nerdtree' | Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'matveyt/vim-modest'
    Plug 'SirVer/ultisnips'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'lervag/vimtex'
    Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
    Plug 'voldikss/vim-floaterm'
    Plug 'jalvesaq/Nvim-R'
    Plug 'kevinoid/vim-jsonc'
    Plug 'jpalardy/vim-slime'
    "Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown'
    "Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install', 'for': ['markdown', 'pandoc.markdown', 'rmd']  }
    "Plug 'vim-pandoc/vim-pandoc'
    "Plug 'vim-pandoc/vim-pandoc-syntax'
    "Plug 'vim-pandoc/vim-rmarkdown'
    "Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
    "Plug 'sheerun/vim-polyglot'
call plug#end()

let mapleader = ","

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ ultisnips
" First look at honza snippets location, then at .config/nvim/snips for snippets
let g:UltiSnipsSnippetDirectories=[expand("~/.config/nvim/snips")]
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsEditSplit="tabdo"
"}}}
"{{{ vimtex
let g:tex_flavor='latex'
"let g:vimtex_view_method='skim'
let g:vimtex_view_method='zathura'
"let g:vimtex_quickfix_mode=2
"let g:vimtex_quickfix_mode=0
"let g:vimtex_fold_enabled=1

" cleanup files (reads ~/.latexmkrc and runs latexmk -c, can use it with \lc)
" see https://github.com/lervag/vimtex/issues/576 for details
augroup MyVimtex
  autocmd!
  autocmd User VimtexEventQuit call vimtex#latexmk#clean(0)
augroup END
"}}}
"{{{ tex-conceal
set conceallevel=2
let g:tex_conceal="abdmg"
let g:tex_superscripts= "[0-9a-zA-W.,:;+-<>/()=]"
let g:tex_subscripts= "[0-9aehijklmnoprstuvx,+-/().]"
let g:tex_conceal_frac=1
hi Conceal ctermbg=none
"}}}
"{{{ coc.nvim
let g:python3_host_prog = expand('~/miniconda3/bin/python')
let g:node_host_prog = expand('~/miniconda3/bin/npx')
let g:coc_node_path = expand('~/miniconda3/bin/node')

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Applying codeAction to the selected region.
" Example `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Give more space for displaying messages.
"set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=2000

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes
"}}}
" {{{ vim-pandoc
"let g:pandoc#modules#disabled = ["folding"]
"let g:pandoc#modules#disabled = ["spell"]
"let g:pandoc#folding#mode = "stacked"
"autocmd BufWritePost *.Rmd RMarkdown!
"}}}
" {{{ nvim-r
" Nvim-R has some built in snippets that are auto-triggered. This one I find annoying.
let R_rmdchunk = 0

"let R_path = expand('/usr/bin')
"let R_path = expand('~/miniconda3/envs/ksink_env/bin')

"let R_openhtml = 1
"let R_auto_start = 1

" Trying to get python completion working ... no luck so far
let g:markdown_fenced_languages = ['r', 'python']
let g:rmd_fenced_languages = ['r', 'python']

" If in tmux, open R in a new tmux pane (horizontal split)
if $TMUX != ''
    let R_source = '~/.config/nvim/nvimr-tmux-config/tmux_split.vim'
    let R_tmux_title = 'automatic'
endif

let R_rconsole_width = 0  " always use horizontal splits when opening R,
let R_rconsole_height = 5 " -- horizontal splits that are 5 rows high.
"}}}
" {{{ vim-slime
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "2"}
let g:slime_no_mappings = 1
xmap <leader>cv <Plug>SlimeRegionSend
nmap <leader>cv <Plug>SlimeParagraphSend
"nmap <leader>vv  <Plug>SlimeConfig
"}}}
"{{{ coc-explorer
let g:coc_explorer_global_presets = {
\   '.nvim': {
\     'root-uri': '~/.config/nvim',
\   },
\   'tab': {
\     'position': 'tab',
\     'quit-on-open': v:true,
\   },
\   'floating': {
\     'position': 'floating',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingTop': {
\     'position': 'floating',
\     'floating-position': 'center-top',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingLeftside': {
\     'position': 'floating',
\     'floating-position': 'left-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingRightside': {
\     'position': 'floating',
\     'floating-position': 'right-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'simplify': {
\     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   }
\ }

nmap <leader>ed :CocCommand explorer --preset .nvim<CR>
nmap <leader>ee :CocCommand explorer<CR>
nmap <leader>ff :CocCommand explorer --preset floating<CR>
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif
"}}}
" {{{ floaterm
let g:floaterm_keymap_toggle = '<F1>'
let g:floaterm_keymap_next   = '<F2>'
let g:floaterm_keymap_prev   = '<F3>'
let g:floaterm_keymap_new    = '<F4>'

" Floaterm
let g:floaterm_gitcommit='floaterm'
let g:floaterm_autoinsert=1
let g:floaterm_width=0.8
let g:floaterm_height=0.8
let g:floaterm_wintitle=0
let g:floaterm_autoclose=1
"}}}
" {{{ NERDTree
" How can I open a NERDTree automatically when vim starts up if no files were specified?
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"How can I open NERDTree automatically when vim starts up on opening a directory?
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

"How can I map a specific key or shortcut to open NERDTree?
map <leader>n :NERDTreeToggle<CR>

"How can I close vim if the only window left open is a NERDTree?
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:NERDTreeGitStatusIndicatorMapCustom = {
              \ 'Modified'  :'✹',
              \ 'Staged'    :'✚',
              \ 'Untracked' :'✭',
              \ 'Renamed'   :'➜',
              \ 'Unmerged'  :'═',
              \ 'Deleted'   :'✖',
              \ 'Dirty'     :'✗',
              \ 'Ignored'   :'☒',
              \ 'Clean'     :'✔︎',
              \ 'Unknown'   :'?',
              \ }
let g:NERDTreeGitStatusConcealBrackets = 1 " default: 0
"}}}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ CSCOPE settings
" This file contains some boilerplate settings for vim's cscope interface,
" plus some keyboard mappings that I've found useful.
"
" USAGE:
" -- vim 6:     Stick this file in your ~/.vim/plugin directory (or in a
"               'plugin' directory in some other directory that is in your
"               'runtimepath'.
"
" -- vim 5:     Stick this file somewhere and 'source cscope.vim' it from
"               your ~/.vimrc file (or cut and paste it into your .vimrc).
"
" NOTE:
" These key maps use multiple keystrokes (2 or 3 keys).  If you find that vim
" keeps timing you out before you can complete them, try changing your timeout
" settings, as explained below.
"

" This tests to see if vim was configured with the '--enable-cscope' option
" when it was compiled.  If it wasn't, time to recompile vim...
if has("cscope")
    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags:
    " (set to 1 if you want the reverse search order)
    set csto=0

    " add any cscope database in current directory,
    " else add the database pointed to by env variable
    if filereadable("cscope.out")
        cs add cscope.out
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif

    " show msg when any other cscope db added
    set cscopeverbose

    " The following maps all invoke one of the following cscope search types:
    "
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    "
    " All of the maps involving the <cfile> macro use '^<cfile>$':
    "  - This is so that searches over '#include <time.h>" return only references to
    "    'time.h', and not 'sys/time.h', etc. Otherwise cscope will return all files
    "    that contain 'time.h' as part of their name).
    "
    " Type 'CTRL-\', followed by one of th cscope search types above (s,g,c,t,e,f,i,d).
    " - The result of your cscope search will be displayed in the current window.
    " - You can use CTRL-T to go back to where you were before the search.
    " - By default CTRL-\'s is part of CTRL-\ CTRL-N typemap, (escape).
    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
    " Same, but display results in a new window (vertical split)
    " (By default 'CTRL-_' switches between Hebrew and English mode.)
    nmap <C-_>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-_>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-_>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>

endif
" }}}
"{{{ Basic mappings
no <leader>so :source $MYVIMRC<CR>
no <leader>vt :tabnew $MYVIMRC<CR>


" Stamping -- replace a word with contents of vim clipboard
nnoremap S diw"0Pb

" cycle through open buffers
nnoremap gb  :bn<CR>
nnoremap gB  :bp<CR>

" paste while in insert mode
inoremap <silent><C-v> <Esc>:set paste<CR>a<C-r>+<Esc>:set nopaste<CR>a

" re-visual text after changing indent
vnoremap > >gv
vnoremap < <gv

"mouse in all modes
set mouse=a

cnoreabbrev <expr> h getcmdtype() == ":" && getcmdline() == 'h' ? 'tab help' : 'h'

"}}}
"{{{ Save the cursor position
augroup save_cursor_position
   autocmd!
   autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END
"}}}
"{{{ Strip trailing whitespace throughout buffer
nnoremap <silent> <Leader>ss
    \ :let _p = getpos(".") <Bar>
    \  let _s = (@/ != '') ? @/ : '' <Bar>
    \  %s/\s\+$//e <Bar>
    \  let @/ = _s <Bar>
    \  nohlsearch <Bar>
    \  unlet _s <Bar>
    \ call setpos('.', _p) <Bar>
    \  unlet _p <CR>
"}}}
"{{{ Search settings
" blink the matching line
function! HLNext (blinktime)
   set invcursorline
   redraw
   exec 'sleep ' . float2nr(a:blinktime * 900) . 'm'
   set invcursorline
   redraw
endfunction

" highlight matches when jumping to next
nnoremap <silent>n n:call HLNext(0.2)<CR>
nnoremap <silent>N N:call HLNext(0.2)<CR>

" search for word under cursor
no <leader>s /<C-R>=expand("<cword>")<CR><CR>
"}}}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Appearance
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ Colorscheme
colorscheme modest
hi TabLine ctermbg=236
hi TabLineFill ctermfg=236 ctermbg=NONE
hi StatusLine ctermfg=236 ctermbg=255
hi StatusLineNC ctermfg=236 ctermbg=255
hi Normal guibg=NONE ctermbg=NONE
highlight Pmenu ctermbg=238
hi BufTablineActive ctermbg=NONE
"}}}
"{{{ Show whitespace
set linebreak
set breakindent
set list listchars=tab:>>,trail:~

if has('multi_byte')
   set list listchars=tab:>>,trail:~
   exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
   "set fillchars=vert:\|, showbreak=_
endif
"}}}
"{{{ Mark text at 85th column
"highlight ColorColumn ctermbg=138
"call matchadd('ColorColumn', '\%86v', 100)
"}}}
"{{{ Folds
autocmd FileType vim,txt setlocal foldmethod=marker
autocmd FileType tex,rmd,conf setlocal foldmethod=marker foldmarker={{{{,}}}}
nnoremap <space> za
hi Folded ctermbg=NONE ctermfg=67
"}}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic vim settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ Tabs vs spaces,
" see https://stackoverflow.com/questions/234564/
" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Use filetype detection and file-based automatic indenting.
    filetype plugin indent on

    " Use actual tab chars in Makefiles.
    autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
endif

" For everything else, use a tab width of 4 space chars.
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set shiftwidth=4    " Indents will have a width of 4. (4 spaces)
set softtabstop=4   " Sets the number of columns for a TAB. (number of spaces)
set expandtab       " Expand TABs to spaces. (Tab key inserts spaces not tabs)
"}}}
"{{{ netrw settings
"let g:netrw_altv = 1
"let g:netrw_liststyle = 3
"let g:netrw_browse_split = 3
"}}}
set number                  " enable line numbers
set noswapfile              " needed for Docker volumes , see https://github.com/moby/moby/issues/15793
set splitright
set splitbelow
set modeline                " enable vim modelines
set nowrap
set wildmenu                " Tab completion menu when using command mode
set iskeyword+=-            " treat dash separated words as a word text object"

"autocmd FileType rmd CocAction('toggleExtension', 'coc-python')

" spelling -- from Gilles
"setlocal spell
"set spelllang=en_us
"inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
