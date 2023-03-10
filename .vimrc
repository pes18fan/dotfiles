call plug#begin() " calls vim-plug

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ghifarit53/tokyonight-vim' " tokyo night theme
Plug 'jiangmiao/auto-pairs' " auto-pairs
Plug 'wincent/terminus' " variable cursor shapes etc
Plug 'vim-airline/vim-airline' " cool status bar
Plug 'morhetz/gruvbox'

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

inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<TAB>"
inoremap <silent><expr> <cr> "\<c-g>u\<CR>"

let g:svelte_indent_script = 0
let g:svelte_indent_style = 0

let g:cpp_class_decl_highlight = 1

let g:ale_fixers = {'javascript': ['eslint'], 'typescript': ['eslint']}

let g:ale_disable_lsp = 1

set termguicolors
set background=dark

colorscheme gruvbox

set number

set laststatus=2

set tabstop=4
set sts=4
set shiftwidth=4
set smartindent
set autoindent
