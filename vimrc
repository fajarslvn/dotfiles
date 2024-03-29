" settings
filetype on
filetype plugin on

set t_Co=256
syntax on 
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
set updatetime=400
set number 
set relativenumber
set foldenable

" Indentation
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab

set nocompatible
set wildmenu
set autochdir
set clipboard=unnamed
set ruler
set laststatus=2
set backspace=indent,eol,start
set wrap
set linebreak
set nolist
set showcmd
set lazyredraw
set autowrite
set timeoutlen=1000 ttimeoutlen=0
set nostartofline
set showmatch
set noshowmode
set signcolumn=yes
set hidden
set ttyfast

" Open splits on the right and below
set splitbelow
set splitright

" ignore annoying swapfile messages
set shortmess+=A
" no splash screen
set shortmess+=I
" file-read message overwrites previous
set shortmess+=O
" truncate non-file messages in middle
set shortmess+=T
" don't echo "[w]"/"[written]" when writing
set shortmess+=W
" use abbreviations in messages eg. `[RO]` instead of `[readonly]`
set shortmess+=a
" don't give |ins-completion-menu| messages.
set shortmess+=c
" overwrite file-written messages
set shortmess+=o
" truncate file messages at start
set shortmess+=t

" always show signcolumns
set signcolumn=yes

" update vim after file update from outside
set autoread

" clipboard
set clipboard=unnamed

" no swap files
set noswapfile
set nobackup
set nowritebackup
set nowb

" plugin
call plug#begin('~/.vim/plugged')

"> Go 
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"> Javascript-Html-css
Plug 'jparise/vim-graphql'
Plug 'mattn/emmet-vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim' 
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

"> General
Plug 'preservim/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'
Plug 'mkitt/tabline.vim'
Plug 'kqito/vim-easy-replace'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'frazrepo/vim-rainbow'

"> Theme 
Plug 'dracula/vim', {'as': 'dracula'}

call plug#end()

" colors
colorscheme dracula
set termguicolors

let g:rainbow_active = 1

let mapleader="\<Space>"

" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = 'find %s -type f'
let g:ctrlp_root_markers = ['pom.xml', '.p4ignore']
let g:ctrlp_switch_buffer = 'et'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll)$',
    \ 'link': 'some_bad_symbolic_links',
    \ }
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']


let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" remap
inoremap jk <Esc>
nnoremap tt :below terminal<CR>
vmap <D-j> gj
vmap <D-k> gk
vmap <D-4> g$
vmap <D-6> g^
vmap <D-0> g0
nmap <D-j> gj
nmap <D-k> gk
nmap <D-4> g$
nmap <D-6> g^
nmap <D-0> g0

" NERDTree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" coc.nvim default settings
inoremap <leader><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

let g:coc_global_extensions = [
  \ 'coc-tsserver'
  \ ]

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Use <c-space> to trigger completion.
inoremap <leader><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <leader> [c <Plug>(coc-diagnostic-prev)
nmap <leader> ]c <Plug>(coc-diagnostic-next)

"" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
	let l:file = expand('%')
	if l:file =~# '^\f\+_test\.go$'
		call go#test#Test(0, 1)
	elseif l:file =~# '^\f\+\.go$'
		call go#cmd#Build(0)
	endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
autocmd FileType go nmap <leader>t <Plug>(go-test)

autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

autocmd FileType go setlocal foldmethod=expr foldexpr=getline(v:lnum)=~'^\s*'.&commentstring[0]

let g:go_list_type = "quickfix"    " error lists are of type quickfix
let g:go_fmt_command = "goimports" " automatically format and rewrite imports
let g:go_auto_sameids = 1          " highlight matching identifiers
let g:go_fmt_experimental = 1

"-- coc.nvim specific configuration

if has("patch-8.1.1564")
	set signcolumn=yes
else
	set signcolumn=number
endif

highlight clear SignColumn

nnoremap <leader> K :call <SID>show_documentation()<CR>

" Emmet
let g:user_emmet_install_global = 0
autocmd FileType gohtml,html,css EmmetInstall
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

"Markdown Preview
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_browser = ''
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }

let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'
let g:mkdp_filetypes = ['markdown']

