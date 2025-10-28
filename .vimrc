scriptencoding utf-8

set nocompatible

filetype plugin indent on

syntax on

set exrc
set secure
set rtp+=/usr/local/opt/fzf

call plug#begin('~/.vim/plugged')
  Plug '/usr/local/opt/fzf'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'OmniSharp/omnisharp-vim'
  Plug 'dense-analysis/ale'
  Plug 'hashivim/vim-terraform'
  Plug 'janko-m/vim-test'
  Plug 'leafgarland/typescript-vim'
  Plug 'mxw/vim-jsx'
  Plug 'pangloss/vim-javascript'
  Plug 'peitalin/vim-jsx-typescript'
  Plug 'rust-lang/rust.vim'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rails'
  Plug 'vim-ruby/vim-ruby'
  Plug 'morhetz/gruvbox'
  Plug 'bakudankun/pico-8.vim'
  Plug 'github/copilot.vim'
  Plug 'tpope/vim-fireplace'
  Plug 'tpope/vim-salve'
  Plug 'camgunz/amber'
  Plug 'alligator/accent.vim'
  Plug 'habamax/vim-godot'
  Plug 'dracula/vim', { 'as': 'dracula' }
  Plug 'editorconfig/editorconfig-vim'
  Plug 'catppuccin/vim', { 'as': 'catppuccin' }
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }
  Plug 'KeitaNakamura/neodark.vim'
call plug#end()

let g:accent_darken = 1

set encoding=utf-8
set hidden
set clipboard=unnamed
set visualbell
set t_vb=
set scrolloff=3
set splitbelow
set splitright
set statusline=\ %<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
set title
set titleold=""
set titlestring=%F
set history=1000
set nobackup
set nowritebackup
set noswapfile
set directory=/tmp
set undodir=/tmp
set undofile
set undolevels=1000
set undoreload=10000
set relativenumber
set nowrap
set showbreak=↪
set textwidth=78
set colorcolumn=81
set ruler
set number
set numberwidth=5
set laststatus=2
set cmdheight=1
set showcmd
set wildmode=longest,list
set wildignore+=**/dist,**/bower_components,**/node_modules,tmp,docker_data,build
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smarttab
set nojoinspaces
set backspace=indent,eol,start
set list
set listchars=tab:\|\ ,trail:·,extends:>,precedes:<,nbsp:·
set foldmethod=manual
set nofoldenable
set showmatch
set hlsearch
set incsearch
set ignorecase
set smartcase
set grepprg=rg\ --vimgrep

let mapleader=","

command! W :w
command! Q :q
command! Ccl :ccl
command! Bd :bd

map <F1> <nop>
map <F1> <nop>
map <Left>  <nop>
map <Right> <nop>
map <Up>    <nop>
map <Down>  <nop>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>r :Rg<CR>
nnoremap <leader><leader> <c-^>
nnoremap / /\v
vnoremap / /\v
nnoremap <CR> :nohlsearch<cr>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>w :set invwrap wrap?<CR>


nnoremap <leader>e $v%lohc<CR><CR><Up><C-r>"<Esc>:s/,/,\r/g<CR>:'[,']norm ==<CR>

colorscheme default
" set termguicolors
" let g:gruvbox_contrast_dark='medium'
" let g:gruvbox_contrast_light='hard'
" colorscheme gruvbox
" set background=dark
" hi LspCxxHlGroupMemberVariable guifg=#83a598

" tab autocompletion or indentation depending on context
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" rename file
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'))
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>sa :call RenameFile()<cr>

" strip trailing whitespace
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>

" vim-test
let test#strategy = "dispatch"
let test#javascript#mocha#options = '-R spec --compilers js:babel-core/register'
nmap <silent> <leader>T :TestNearest<CR>
nmap <silent> <leader>t :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

" ale
let g:ale_enabled = 1
let g:ale_linters_explicit = 1
let g:ale_completion_enabled = 1
let g:ale_virtualtext_cursor = 'disabled'
let g:ale_fix_on_save = 1
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'cs': ['dotnet-format'],
      \ 'javascript': [ 'prettier_standard' ],
      \ 'python': ['ruff_format'],
      \ 'ruby': ['rubocop', 'standardrb'],
      \ 'rust': ['rustfmt'],
      \ 'lua': ['prettier'],
      \ 'terraform': ['terraform'],
      \ 'sql': ['sqlfluff'],
      \ }
      " \ 'python': ['black'],
let g:ale_line_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_change = 'normal'
let g:ale_linters = {
      \ 'cs': ['OmniSharp'],
      \ 'javascript': [''],
      \ 'python': ['ruff'],
      \ 'ruby': ['rubocop', 'standardrb'],
      \ 'rust': ['cargo'],
      \ 'lua': ['prettier'],
      \ 'terraform': ['terraform', 'tflint'],
      \ 'sql': ['sqlfluff'],
      \ }
      " \ 'python': ['flake8', 'isort'],
let g:ale_sign_column_always = 1
highlight clear ALEErrorSign
highlight clear ALEWarningSign
highlight clear SignColumn


" ALESignColumnWithoutErrors
" highlight SignColumn ctermbg=black guibg=black

nmap <leader>1 <Plug>(ale_fix)
nmap <silent> gd :ALEGoToDefinition<CR>
nmap <silent> gh :ALEHover<CR>

nnoremap <leader>jq :%!jq .<CR>

let g:ale_python_flake8_options = "--ignore=E501,E226,E741"

let g:ale_set_highlights = 0

" fugitive
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gr :Gread<cr>

" fzf
let $BAT_THEME = 'ansi'
let g:fzf_layout = { 'down': '~33%' }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'query':   ['fg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" omnisharp
autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
autocmd FileType cs nmap <silent> <buffer> gi <Plug>(omnisharp_find_implementations)
autocmd FileType cs nmap <silent> <buffer> <F2> <Plug>(omnisharp_rename)

autocmd FileType cs nmap <silent> <buffer> ca <Plug>(omnisharp_code_actions)
autocmd FileType cs xmap <silent> <buffer> ca <Plug>(omnisharp_code_actions)
autocmd FileType cs nmap <silent> <buffer> fu <Plug>(omnisharp_find_usages)
autocmd FileType cs nmap <silent> <buffer> fi <Plug>(omnisharp_find_implementations)
autocmd FileType cs nmap <silent> <buffer> pd <Plug>(omnisharp_preview_definition)
autocmd FileType cs nmap <silent> <buffer> pi <Plug>(omnisharp_preview_implementations)
autocmd FileType cs nmap <silent> <buffer> tl <Plug>(omnisharp_type_lookup)
autocmd FileType cs nmap <silent> <buffer> dc <Plug>(omnisharp_documentation)
autocmd FileType cs nmap <silent> <buffer> fs <Plug>(omnisharp_find_symbol)
autocmd FileType cs nmap <silent> <buffer> cx <Plug>(omnisharp_fix_usings)
autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
autocmd FileType cs imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

" autocmd BufWritePre *.cs :OmniSharpCodeFormat | noautocmd write
" autocmd BufWrite *.cs :OmniSharpCodeFormat
" autocmd BufWritePost <buffer> :OmniSharpCodeFormat
" autocmd FileType cs autocmd BufWritePre <buffer> :OmniSharpCodeFormat | noautocmd write
" autocmd BufWrite *.cs call OmniSharpCodeFormat()
" autocmd BufWritePre *.cs <Plug>(omnisharp_code_format)

let g:OmniSharp_server_use_net6 = 0
let g:omnisharp_fzf_options = { 'window': 'botright 7new' }
let g:omnisharp_highlighting = 2
let g:omnisharp_loglevel = 'none'
let g:omnisharp_open_quickfix = 1
let g:omnisharp_popup = 1
let g:omnisharp_popup_mappings = {
      \ 'close': ['<Esc>', 'q'],
      \ 'halfPageDown': ['<C-d>', 'd'],
      \ 'halfPageUp': ['<C-u>', 'u']
      \}
let g:omnisharp_popup_options = {
      \ 'highlight': 'Normal',
      \ 'border': [1],
      \ 'borderchars': [' '],
      \ 'borderhighlight': ['Visual']
      \}
let g:omnisharp_popup_position = 'center'
let g:omnisharp_selector_findusages = 'fzf'
let g:omnisharp_selector_ui = 'fzf'
let g:omnisharp_server_stdio = 1
let g:omnisharp_server_type = 'roslyn'
let g:omnisharp_timeout = 5
let g:omnisharp_want_snippet=1
nnoremap <leader>cf :OmniSharpCodeFormat<cr>

" copilot
imap <silent> <C-j> <Plug>(copilot-next)
imap <silent> <C-k> <Plug>(copilot-previous)
imap <silent> <C-\> <Plug>(copilot-dismiss)

" markdown-preview
nmap <leader>md :MarkdownPreview<CR>
nmap <leader>mD :MarkdownPreviewStop<CR>
nmap <leader>mt :MarkdownPreviewToggle<CR>

" terraform
let g:terraform_fmt_on_save = 1

" godot
call ale#linter#Define('gdscript', {
\   'name': 'godot',
\   'lsp': 'socket',
\   'address': '127.0.0.1:6008',
\   'project_root': 'project.godot',
\})
func! GodotSettings() abort
    nmap <silent> <leader>t :GodotRunCurrent<CR>
    nmap <silent> <leader>a :GodotRun<CR>
    nmap <silent> <leader>l :GodotRunLast<CR>
    nmap <silent> <leader>g :GodotRunFZF<CR>
endfunc
augroup godot | au!
    au FileType gdscript call GodotSettings()
augroup end

command! PromoteToRSpecLet :call PromoteToRSpecLet()
map <leader>pl :PromoteToRSpecLet<CR>

function! PromoteToRSpecLet()
  :normal! dd
  :normal! P
  :.s/\(\w\+\) = \(.*\)/let(:\1) { \2 }/
  :normal! ==
endfunction

augroup Vim
  autocmd!
  " reload vimrc after saving
  autocmd BufWritePost ~/.vimrc so ~/.vimrc
  " autocmd FocusGained * silent :redraw!
  " create the directory if it doesn't exist
  autocmd BufNewFile * silent !mkdir -p $(dirname %)
  " open to last known cursor position
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
  " size windows on enter
  autocmd WinEnter *
    \ if winwidth(winnr()) < 100 |
    \   exec "vertical resize 100" |
    \ end
augroup END
