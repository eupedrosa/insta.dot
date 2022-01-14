set encoding=utf8

" Auto install vim-plug if it does not exist.
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'lewis6991/impatient.nvim'

Plug 'matbme/JABS.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'

Plug 'nvim-lualine/lualine.nvim'

Plug 'mhinz/vim-signify'
Plug 'ntpeters/vim-better-whitespace'

Plug 'folke/trouble.nvim', {'on': ['Trouble']}
Plug 'kyazdani42/nvim-web-devicons'

Plug 'scrooloose/nerdtree',    {'on': ['NERDTreeToggle', 'NERDTreeFind']}
Plug 'ryanoasis/vim-devicons', {'on': ['NERDTreeToggle', 'NERDTreeFind']}

Plug 'tpope/vim-surround',          {'for': ['c', 'cpp', 'python', 'cmake', 'xml', 'vim', 'lua', 'tex']}
Plug 'tpope/vim-commentary',        {'for': ['c', 'cpp', 'python', 'cmake', 'xml', 'vim', 'lua', 'tex']}

Plug 'ray-x/lsp_signature.nvim',    {'for': ['c', 'cpp', 'python', 'cmake', 'xml', 'vim', 'lua', 'tex']}
Plug 'ray-x/guihua.lua',            {'do': 'cd lua/fzy && make' }
Plug 'ray-x/navigator.lua'

Plug 'tpope/vim-fugitive',  {'on': ['G']}
Plug 'junegunn/goyo.vim',   {'on': ['Goyo']}

Plug 'lervag/vimtex',   {'for':'tex'}
Plug 'dbmrq/vim-bucky', {'for':'tex'}

Plug 'max397574/better-escape.nvim'

" Colors
Plug 'shaunsingh/nord.nvim'
call plug#end()

"== Plugins Configuration =="

lua <<EOF

require('impatient')

require'jabs'.setup()

vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = { enable = true, additional_vim_regex_highlighting = false },
  indent    = { enable = false }
}

require'lsp_signature'.setup{ hint_enable = false }

local lsputil = require 'lspconfig/util'
require'navigator'.setup{
    lsp_signature_help = true,
    lsp = {
        format_on_save = false,
        disable_lsp = {'ccls'}, -- make sure ccls is disabled
        clangd = {
            cmd = { "clangd", "--background-index", "--compile-commands-dir=build",
                    "--suggest-missing-includes", "--header-insertion=iwyu"},
            root_dir = function(fname)
            return lsputil.root_pattern('compile_flags.txt')(fname)
                or lsputil.root_pattern('compile_commands.json', '.git')(fname)
                or lsputil.path.dirname(fname)
        end,
        }, -- end of clangd
    }, -- end of lsp
}

local cmp = require'cmp'
cmp.setup({
    mapping = {
        ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
        ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4),    { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4),     { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(),     { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close(), }),
        --['<CR>'] = cmp.mapping.confirm({ select = false }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp', max_item_count = 50, group_index = 1 },
        { name = 'buffer',   max_item_count = 10, group_index = 2 },
        { name = 'path',     max_item_count = 10, group_index = 3 }
        }),
    completion = { keyword_length = 1 },

    experimental = {ghost_text = true}
})

if vim.o.ft == 'clap_input' and vim.o.ft == 'guihua' and vim.o.ft == 'guihua_rust' then
    require'cmp'.setup.buffer { completion = {enable = false} }
end

require'better_escape'.setup{ mapping = {"jk"} }
require'lualine'.setup()

EOF


" White Spaces
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0
let g:better_whitespace_filetypes_blacklist = ['diff', 'gitcommit']

"== Options =="
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
set wildignore+=*.egg-info,__pycache__
set title
set titlestring=vim
set titleold=zsh
set titlelen=20
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

set termguicolors

let g:nord_contrast = v:true
let g:nord_borders = v:true
let g:nord_disable_background = v:false
let g:nord_italic = v:false

colorscheme nord

" NERDTree
let NERDTreeMinimalUI=1
let NERDTreeWinPos=1
let NERDTreeQuitOnOpen=1
let NERDTreeRespectWildIgnore=1
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ''
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true

" vimtex
" For reverse search to work with neovim you must
" install neovim-remote `pip3 install neovim-remote`
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_open_on_warning=0
let g:vimtex_compiler_latexmk = {'build_dir':'build'}
let g:vimtex_imaps_leader = "'"

"== Auto Commands ==
augroup opt
    autocmd!
    autocmd InsertEnter,InsertLeave * set cul!
    autocmd FileType nerdtree setlocal signcolumn=no
    " Quit if NERDTree is the last window
    autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.IsOpen()) | q | endif
    " tex
    autocmd FileType tex setlocal tw=99 cc=100
    autocmd BufReadPre *.tex let b:vimtex_main = 'main.tex'
augroup END

"== Mappings =="
let mapleader=','
let maplocalleader=' '

" map these useless keys to something
" more useful like { and }
imap « {
imap » }

" Quick shortcuts
"   - back to normal
"   - save
"   - undo
"imap jk <esc>
nnoremap <silent> <leader>s :<c-u>update<cr>
nnoremap U <c-r>

" Navigate wrap lines as normal lines
nnoremap j gj
nnoremap k gk
" Keep the visual selections after indenting
vnoremap < <gv
vnoremap > >gv

" Signify
nnoremap <silent> <leader>d :<c-u>SignifyHunkDiff<cr>
" nnoremap <silent> <space> :<c-u>SignifyHunkDiff<cr>
" nnoremap <silent> dh :<c-u>SignifyHunkUndo<cr>

" NERDTree
nnoremap <silent> <leader>o :<c-u>SymbolsOutline<cr>
nnoremap <silent> <leader>n :<c-u>NERDTreeToggle<cr>
nnoremap <silent> <leader>v :<c-u>NERDTreeFind<cr>

" window navigation
nnoremap <leader><leader> <c-^>
nnoremap <silent> <tab> <c-w>w
nnoremap <silent> <leader>q <c-w>q

