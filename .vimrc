call plug#begin() " calls vim-plug

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ghifarit53/tokyonight-vim' " tokyo night theme
Plug 'jiangmiao/auto-pairs' " auto-pairs
Plug 'wincent/terminus' " variable cursor shapes etc
Plug 'vim-airline/vim-airline' " cool status bar

" linter
Plug 'w0rp/ale'

" syntax highlighting et cetera
Plug 'sheerun/vim-polyglot'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'evanleck/vim-svelte'
Plug 'pangloss/vim-javascript'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'codechips/coc-svelte', {'do': 'npm install'}

call plug#end()

let g:svelte_indent_script = 0
let g:svelte_indent_style = 0

let g:cpp_class_decl_highlight = 1

let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 0
let g:tokyonight_disable_italic_comment = 1

let g:ale_fixers = {'javascript': ['eslint'], 'typescript': ['eslint']}

let g:ale_disable_lsp = 1

set termguicolors
set background=dark

colorscheme tokyonight

set number

set laststatus=2

set tabstop=4
set sts=4
set shiftwidth=4
set smartindent
set autoindent
