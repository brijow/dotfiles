call plug#begin(stdpath('data') . '/plugged')
    Plug 'neovim/nvim-lspconfig'  " Collection of configurations for built-in LSP client
    Plug 'williamboman/nvim-lsp-installer'  " simple to use language server installer

    Plug 'nvim-lua/plenary.nvim'  " Useful lua functions used by lots of plugins

    Plug 'hrsh7th/nvim-cmp'       " Autocompletion plugin
    Plug 'hrsh7th/cmp-nvim-lsp'   " LSP source for nvim-cmp
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'

    "Plug 'hrsh7th/cmp-vsnip'
    "Plug 'hrsh7th/vim-vsnip'

    Plug 'SirVer/ultisnips'
    Plug 'quangnguyen30192/cmp-nvim-ultisnips'




    Plug 'scrooloose/nerdcommenter'
    Plug 'matveyt/vim-modest'
    Plug 'jpalardy/vim-slime'
    Plug 'lervag/vimtex'
    Plug 'jalvesaq/Nvim-R'
    "Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown'
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install', 'for': ['markdown', 'pandoc.markdown', 'rmd']  }
    "Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
    "Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
    Plug 'junegunn/goyo.vim'"


    "Plug 'vim-pandoc/vim-pandoc'
    "Plug 'vim-pandoc/vim-pandoc-syntax'
    "Plug 'vim-pandoc/vim-rmarkdown'
    "Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
    "Plug 'sheerun/vim-polyglot'
call plug#end()

"{{{ initial settings
let g:mapleader = ','
"let g:python_host_prog = expand('~/miniconda3/envs/brian/bin/python')
"let g:python3_host_prog = expand('~/miniconda3/envs/brian/bin/python')
"let g:node_host_prog = expand('~/miniconda3/envs/neovim/bin/npx')
"let g:perl_host_prog = expand('~/miniconda3/envs/neovim/bin/perl')
"}}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin settings configured with vimscript
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ netrw settings
"let g:netrw_altv = 1
"let g:netrw_liststyle = 3
"let g:netrw_browse_split = 3
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
" {{{ nvim-r
"let R_path = expand('~/opt/miniconda3/envs/brian/bin')
"let R_openhtml = 0
"if $TMUX != ''
"    let R_source = '~/.config/nvim/nvimr-tmux/tmux_split.vim'
"    let R_tmux_title = 'automatic'
"endif
"}}}
"{{{ vimtex
let g:tex_flavor='latex'
"let g:vimtex_view_method='skim'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=2

let g:vimtex_compiler_latexmk = { 
        \ 'executable' : 'latexmk',
        \ 'options' : [ 
        \   '-xelatex',
        \   '-shell-escape',
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
" {{{ vim-pandoc
"let g:pandoc#modules#disabled = ["folding"]
"let g:pandoc#modules#disabled = ["spell"]
"let g:pandoc#folding#mode = "stacked"
"autocmd BufWritePost *.Rmd RMarkdown!
"}}}
"{{{ neoformat
"let g:neoformat_python_autopep8 = {
"            \ 'exe': 'autopep8',
"            \ 'args': ['-s 4', '-E'],
"            \ 'replace': 0,
"            \ 'stdin': 1,
"            \ 'env': ["DEBUG=1"],
"            \ 'valid_exit_codes': [0, 23],
"            \ 'no_append': 1,
"            \ }

"let g:neoformat_enabled_python = ['black' ]
"let g:neoformat_enabled_python = ['yapf' ]
"no <leader>nf :Neoformat<CR>
"}}}
"{{{ jupytext
"let g:jupytext_fmt = 'py'
"}}}
"{{{ ultisnips
let g:UltiSnipsSnippetDirectories=[$HOME . "/.config/nvim/ultisnips"]
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsEditSplit="tabdo"
"}}}
"{{{ goyo
autocmd BufNewFile,BufRead *.vpm call SetVimPresentationMode()
function SetVimPresentationMode()
    nnoremap <buffer> <Right> :n<CR>
    nnoremap <buffer> <Left> :N<CR>

    if !exists('#goyo')
        Goyo
    endif
endfunction
"}}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin settings configured with lua
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ lsp (in-line lua)
lua << EOF
-------------------------------------------------------------------------------
-- build up a lua table to use with nvim-lsp-installer
local handlers_table = {}

handlers_table.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "gl",
    '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>',
    opts
  )
  vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

handlers_table.on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    client.resolved_capabilities.document_formatting = false
  end
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local cmp_nvim_lsp = require 'cmp_nvim_lsp'

handlers_table.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
-- end of handlers_table construction
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- nvim-lsp-installer config
local lsp_installer = require 'nvim-lsp-installer'

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = handlers_table.on_attach,
        capabilities = handlers_table.capabilities,
    }

     -- if server.name == "jsonls" then
     --    local jsonls_opts = require("my_lsp_settings.jsonls")
     --    opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
     -- end

     -- if server.name == "sumneko_lua" then
     --    local sumneko_opts = require("my_lsp_settings.sumneko_lua")
     --    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
     -- end

     if server.name == "pyright" then
         local pyright_opts = {
             settings = {
                 python = {
                     analysis = {
                         typeCheckingMode = "off"
                         }
                     }
                 },
             }
        opts = vim.tbl_deep_extend("force", pyright_opts, opts)
     end

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)
-------------------------------------------------------------------------------

-- finally, call setup()
handlers_table.setup()
EOF
"}}}
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "gl",
    '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>',
    opts
  )
  vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'r_language_server' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF
"{{{ nvim-cmp (in-line lua)
lua << EOF
local cmp = require 'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body)
      vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    -- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
    -- ['<C-Space>'] = cmp.mapping.complete(),
    -- ['<C-e>'] = cmp.mapping.close(),
    -- ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'ultisnips' },
    --{ name = 'vsnip' },
  })
})
EOF
"}}}
"{{{ vim-vsnip (in-line lua)
"lua << EOF
"vim.cmd [[
"  let g:vsnip_snippet_dir = expand("~/.config/nvim/vsnips")
"  let g:vsnip_filetypes = {}
"  let g:vsnip_filetypes.javascriptreact = ['javascript']
"  let g:vsnip_filetypes.typescriptreact = ['typescript']
"]]
"
"-- NOTE: read this https://github.com/L3MON4D3/LuaSnip for example on how to convert vimscript to lua for snippet config
"vim.api.nvim_set_keymap("i", "<C-j>", "<Plug>(vsnip-expand-or-jump)", {})
"vim.api.nvim_set_keymap("s", "<C-j>", "<Plug>(vsnip-expand-or-jump)", {})
"vim.api.nvim_set_keymap("i", "<C-k>", "<Plug>(vsnip-jump-prev)", {})
"vim.api.nvim_set_keymap("s", "<C-k>", "<Plug>(vsnip-jump-prev)", {})
"EOF
"}}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings, appearance, and basic vim settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ mappings
set mouse=a

nnoremap <leader>e :Lex 30<CR>
nnoremap <leader>so :source $MYVIMRC<CR>
nnoremap <leader>vt :tabnew $MYVIMRC<CR>
" Stamping -- replace a word with contents of vim clipboard
nnoremap S diw"0Pb
nnoremap gb  :bn<CR>
" cycle through open buffers
nnoremap gB  :bp<CR>
" paste while in insert mode
inoremap <silent><C-v> <Esc>:set paste<CR>a<C-r>+<Esc>:set nopaste<CR>a
" re-visual text after changing indent
vnoremap > >gv
vnoremap < <gv
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
"{{{ Colorscheme
colorscheme modest
hi TabLine ctermbg=236
hi TabLineFill ctermfg=236 ctermbg=NONE
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
"{{{ Line numbers, menus, and wrapping
set number
set modeline
set wildmenu
set nowrap
"}}}
"{{{ Folds
autocmd FileType vim,txt,python setlocal foldmethod=marker
autocmd FileType tex,rmd setlocal foldmethod=marker foldmarker={{{{,}}}}
nnoremap <space> za
hi Folded ctermbg=NONE ctermfg=67
"}}}
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
"{{{ Vertical split to the right, horizontal split below
set splitright
set splitbelow
"}}}
"{{{ No swap file  (needed for Docker volumes , see https://github.com/moby/moby/issues/15793)
set noswapfile
"}}}

"{{{ nvim-from-scratch options.lua
" lua << EOF
" vim.opt.backup = false                          -- creates a backup file
" vim.opt.clipboard = 'unnamedplus'               -- allows neovim to access the system clipboard
" vim.opt.cmdheight = 2                           -- more space in the neovim command line for displaying messages
" vim.opt.completeopt = { 'menuone', 'noselect' } -- mostly just for cmp
" vim.opt.conceallevel = 0                        -- so that `` is visible in markdown files
" vim.opt.fileencoding = 'utf-8'                  -- the encoding written to a file
" vim.opt.hlsearch = true                         -- highlight all matches on previous search pattern
" vim.opt.ignorecase = true                       -- ignore case in search patterns
" vim.opt.pumheight = 10                          -- pop up menu height
" vim.opt.showmode = false                        -- we don't need to see things like -- INSERT -- anymore
" vim.opt.showtabline = 2                         -- always show tabs
" vim.opt.smartcase = true                        -- smart case
" vim.opt.smartindent = true                      -- make indenting smarter again
" vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
" vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window
" vim.opt.swapfile = false                        -- creates a swapfile
" vim.opt.termguicolors = true                    -- set term gui colors (most terminals support this)
" vim.opt.timeoutlen = 1000                       -- time to wait for a mapped sequence to complete (in milliseconds)
" vim.opt.undofile = true                         -- enable persistent undo
" vim.opt.updatetime = 300                        -- faster completion (4000ms default)
" vim.opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
" vim.opt.expandtab = true                        -- convert tabs to spaces
" vim.opt.shiftwidth = 2                          -- the number of spaces inserted for each indentation
" vim.opt.tabstop = 2                             -- insert 2 spaces for a tab
" vim.opt.cursorline = true                       -- highlight the current line
" vim.opt.number = true                           -- set numbered lines
" vim.opt.relativenumber = false                  -- set relative numbered lines
" vim.opt.numberwidth = 4                         -- set number column width to 2 {default 4}
" vim.opt.signcolumn = 'yes'                      -- always show the sign column, otherwise it would shift the text each time
" vim.opt.wrap = false                            -- display lines as one long line
" vim.opt.scrolloff = 8                           -- is one of my fav
" vim.opt.sidescrolloff = 8
" vim.opt.guifont = 'monospace:h17'               -- the font used in graphical neovim applications
" 
" vim.opt.shortmess:append 'c'
" 
" vim.cmd 'set whichwrap+=<,>,[,],h,l'
" vim.cmd [[set iskeyword+=-]]
" vim.cmd [[set formatoptions-=cro]] -- todo: this doesn't seem to work
" EOF
"}}}
set signcolumn=yes
