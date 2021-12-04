call plug#begin(stdpath('data') . '/plugged')
    Plug 'scrooloose/nerdcommenter'
    Plug 'matveyt/vim-modest'
    Plug 'SirVer/ultisnips'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'lervag/vimtex'
    "Plug 'jalvesaq/Nvim-R'
    Plug 'jpalardy/vim-slime'
    "Plug 'cseelus/vim-colors-tone'
    "Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown'
    "Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install', 'for': ['markdown', 'pandoc.markdown', 'rmd']  }
    "Plug 'vim-pandoc/vim-pandoc'
    "Plug 'vim-pandoc/vim-pandoc-syntax'
    "Plug 'vim-pandoc/vim-rmarkdown'
    "Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
    "Plug 'sheerun/vim-polyglot'
call plug#end()

let g:mapleader = ","
let g:python_host_prog = expand('~/miniconda3/envs/neovim/bin/python')
let g:python3_host_prog = expand('~/miniconda3/envs/neovim/bin/python')
let g:node_host_prog = expand('~/miniconda3/envs/neovim/bin/npx')
let g:perl_host_prog = expand('~/miniconda3/envs/neovim/bin/perl')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ ultisnips
let g:UltiSnipsSnippetDirectories=[$HOME . "/.config/nvim/snips"]
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsEditSplit="tabdo"
"}}}
"{{{ vimtex
let g:tex_flavor='latex'
let g:vimtex_view_method='skim'
let g:vimtex_quickfix_mode=2

let g:vimtex_compiler_latexmk = { 
        \ 'executable' : 'latexmk',
        \ 'options' : [ 
        \   '-xelatex',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \ ],
        \}

augroup vimtex_event_1
au!
au User VimtexEventQuit     VimtexClean
"au User VimtexEventInitPost VimtexCompile
augroup END
"}}}
"{{{ tex-conceal
"set conceallevel=1
"let g:tex_conceal="abdmg"
"}}}
"{{{ coc.nvim
let g:coc_node_path = expand('~/miniconda3/envs/neovim/bin/node')
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

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
let R_path = expand('~/opt/miniconda3/envs/ksink_env/bin')
let R_openhtml = 0
if $TMUX != ''
    let R_source = '~/.config/nvim/nvimr-tmux/tmux_split.vim'
    let R_tmux_title = 'automatic'
endif
"}}}
" {{{ vim-slime
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "2"}
let g:slime_no_mappings = 1
let g:slime_python_ipython = 1
"let g:slime_dispatch_ipython_pause
xmap <leader>cv <Plug>SlimeRegionSend
nmap <leader>cv <Plug>SlimeParagraphSend
nmap <leader>vv  <Plug>SlimeConfig
"}}}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
    \  call setpos('.', _p) <Bar>
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
hi TabLineFill ctermfg=236 ctermbg=255
hi StatusLine ctermfg=236 ctermbg=255
hi StatusLineNC ctermfg=236 ctermbg=255
hi Normal guibg=NONE ctermbg=NONE
highlight Pmenu ctermbg=238
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
autocmd FileType vim,txt,python setlocal foldmethod=marker
autocmd FileType tex,rmd setlocal foldmethod=marker foldmarker={{{{,}}}}
nnoremap <space> za
hi Folded ctermbg=NONE ctermfg=67
"}}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic vim settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ Tabs vs spaces,
" see https://stackoverflow.com/questions/234564/
" Only do this part when compiled with support for autocommands.
" For everything else, use a tab width of 4 space chars.
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set shiftwidth=4    " Indents will have a width of 4. (4 spaces)
set softtabstop=4   " Sets the number of columns for a TAB. (number of spaces)
set expandtab       " Expand TABs to spaces. (Tab key inserts spaces not tabs)
if has("autocmd")
    " Use filetype detection and file-based automatic indenting.
    filetype plugin indent on

    " Use actual tab chars in Makefiles.
    autocmd FileType make setlocal tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
    autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=0 expandtab
    autocmd FileType javascriptreact setlocal tabstop=2 shiftwidth=2 softtabstop=0 expandtab
endif

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

