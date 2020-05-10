set encoding=utf8

" Auto install vim-plug if it does not exist.
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'dstein64/vim-startuptime'
" File navigaton
Plug 'junegunn/fzf', {'dir': '~/.local/fzf', 'do': {->fzf#install()}}
Plug 'junegunn/fzf.vim', {'on': ['Files', 'Buffers', 'Lines', 'Ag']}
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
" Text editing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
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
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*

" Visual
colorscheme nord
let g:lightline = {
    \'colorscheme':'nord',
    \'active': { 'left' : [['mode','paste'],['gbranch','readonly','filename','modified']]},
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

" White Spaces
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

" Deoplete
let g:deoplete#enable_at_startup = 0
let g:deoplete#sources#jedi#show_docstring=1
call deoplete#custom#option('auto_complete_delay', 100)
let g:echodoc_enable_at_startup = 1
let g:echodoc#type = 'floating'

" FZF
let g:fzf_preview_window = ''

"""""""""""""""""
" Auto commands "
"""""""""""""""""
augroup opt
    autocmd!
    autocmd InsertEnter * call deoplete#enable()
    autocmd InsertEnter,InsertLeave * set cul!
    autocmd FileType tagbar,nerdtree setlocal signcolumn=no
augroup END

""""""""""""
" Mappings "
""""""""""""
let mapleader=','

imap « {
imap » }
" Quick? exit to normal mode
imap jk <esc>

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

