set encoding=utf8

" Auto install vim-plug if it does not exist.
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
" File navigaton
Plug 'junegunn/fzf', {'dir': '~/.local/fzf', 'do': {->fzf#install()}}
Plug 'junegunn/fzf.vim', {'on': ['Files', 'Buffers', 'Lines', 'Ag']}
Plug 'alok/notational-fzf-vim', {'on': 'NV'}
Plug 'scrooloose/nerdtree',    {'on': ['NERDTreeToggle', 'NERDTreeFind']}
Plug 'ryanoasis/vim-devicons', {'on': ['NERDTreeToggle', 'NERDTreeFind']}
" Visual cues
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-signify'
Plug 'ntpeters/vim-better-whitespace'
" Autocompletion
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/echodoc.vim', {'for' : 'python'}
Plug 'deoplete-plugins/deoplete-jedi', {'for': 'python'}
Plug 'davidhalter/jedi-vim', {'for': 'python'}
" Text editing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'lervag/vimtex', {'for':'tex'}
Plug 'dbmrq/vim-bucky', {'for':'tex'}
" Colors
Plug 'arcticicestudio/nord-vim'
call plug#end()

" Edit Options
set autoindent
set smartindent
set cindent
set expandtab    " Use spaces, not tabs
set smarttab
set softtabstop=4
set shiftwidth=4
set hidden
set noswapfile
set updatetime=1000
set wildignore+=*.o,*.pyc,*.git,*.hg,*.svn,*.bst,*.aux,*.cls,
            \*.fls,*.fdb_labexmk,build/**,lib/**,bin/**,
            \*/build/*,*/devel/*

" Visual
colorscheme nord
let g:lightline = {
    \'colorscheme':'nord',
    \'active': { 'left' : [['mode','spell','paste'],['gbranch','readonly','filename','modified']]},
    \'component_function': {'gbranch':'FugitiveHead'}
\}

set noshowmode
set scrolloff=10        " Keep 10 lines below the last line when scrolling
set display=lastline    " Show as much as posible of the last line
set ruler               " Show cursor position in status line
set report=0
set shortmess=I
set synmaxcol=200
set number
set signcolumn=yes
set cursorline
set incsearch
set nohlsearch
set ignorecase
set smartcase
set completeopt=noinsert,menuone,noselect

" NERDTree
let NERDTreeMinimalUI=1
let NERDTreeWinPos=1
let NERDTreeQuitOnOpen=1
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ''
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true

" White Spaces
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0
let g:better_whitespace_filetypes_blacklist = ['diff', 'gitcommit', 'help', 'markdown']

" Deoplete
let g:deoplete#enable_at_startup = 0
let g:deoplete#sources#jedi#show_docstring=1
call deoplete#custom#option('auto_complete_delay', 100)
let g:echodoc_enable_at_startup = 1
let g:echodoc#type = 'floating'

" Jedi
let g:jedi#usages_command = "<localleader>u"
let g:jedi#goto_command = "<localleader>d"
let g:jedi#goto_assignments_command = "<localleader>g"
let g:jedi#goto_stubs_command = "<localleader>s"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<localleader>n"
let g:jedi#rename_command = "<localleader>r"
let g:jedi#completions_enabled = 0

" FZF
let g:fzf_preview_window = ''

" vimtex
" For reverse search to work with neovim you must install neovim-remote
" `pip3 install neovim-remote`
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_open_on_warning=0
let g:vimtex_latexmk_progname = 'nvr'
let g:vimtex_compiler_latexmk = {'build_dir':'build'}
let g:vimtex_imaps_leader = "'"

" Note taking
let g:nv_search_paths = ['~/notes', './notes']
" Add syntax highligh to coodebloks in markdown
let g:markdown_fenced_languages = ['python', 'bash=sh']

"""""""""""""""""
" Auto commands "
"""""""""""""""""
augroup opt
    autocmd!
    autocmd InsertEnter * call deoplete#enable()
    autocmd InsertEnter,InsertLeave * set cul!
    autocmd FileType tagbar,nerdtree setlocal signcolumn=no
    " Quit if NERDTree is the last window
    autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.IsOpen()) | q | endif
    " tex
    autocmd FileType tex setlocal tw=99 cc=100
    autocmd FileType tex nnoremap <buffer> <silent> <leader>ft :<c-u>call vimtex#fzf#run('ct', {'down':'~40%'})<cr>
augroup END

""""""""""""
" Mappings "
""""""""""""
let mapleader=','
let maplocalleader='\'

imap « {
imap » }
" Quick? exit to normal mode
imap jk <esc>

" Quick window close with 'q'.
" Use 'Q' instead to start recording macros.
nnoremap q <c-w>c
nnoremap Q q

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
"Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

imap <C-k>  <Plug>(neosnippet_expand_or_jump)
smap <C-k>  <Plug>(neosnippet_expand_or_jump)
xmap <C-k>  <Plug>(neosnippet_expand_target)

" Navigate wrap lines as normal lines
nnoremap j gj
nnoremap k gk
" Keep the visual selections after indenting
vnoremap < <gv
vnoremap > >gv

" Quick undo
nnoremap U <c-r>
" Quick save
nnoremap <silent> <leader>s :<c-u>update<cr>

nnoremap <leader><leader> <c-^>
nnoremap <silent> <tab> <c-w>w
nnoremap <silent> <leader>n :<c-u>NERDTreeToggle<cr>
nnoremap <silent> <leader>v :<c-u>NERDTreeFind<cr>
nnoremap <silent> <leader>ff :<c-u>Files<cr>
nnoremap <silent> <leader>fb :<c-u>Buffers<cr>
nnoremap <silent> <leader>fl :<c-u>Lines<cr>

nnoremap <silent> <space> :<c-u>SignifyHunkDiff<cr>
nnoremap <silent> dh :<c-u>SignifyHunkUndo<cr>
