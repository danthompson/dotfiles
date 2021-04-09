set nocompatible

" project-specific vimrc but disable shell and write ops
set exrc
set secure

set shell=/bin/bash
set rtp+=/usr/local/opt/fzf

call plug#begin('~/.vim/plugged')
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-classpath'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/VimClojure'
Plug 'janko-m/vim-test'
Plug 'tpope/vim-abolish'
Plug 'rust-lang/rust.vim'
Plug 'leafgarland/typescript-vim'
Plug 'dense-analysis/ale'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'OmniSharp/omnisharp-vim'
Plug 'slim-template/vim-slim'
Plug 'habamax/vim-colors-defminus'
Plug 'noahfrederick/vim-hemisu'
Plug 'ajmwagar/vim-deus'
Plug 'tomasiser/vim-code-dark'
Plug 'aunsira/macvim-light'
Plug 'taniarascia/new-moon.vim'
Plug 'noahfrederick/vim-noctu'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'liuchengxu/space-vim-theme'
Plug 'yasukotelin/shirotelin'
call plug#end()

set encoding=utf-8              " utf-8
set hidden                      " backgrounding buffers, remember marks/undos
set clipboard=unnamed           " link vim and system clipboard
set visualbell                  " no beeps
set t_vb=                       " really no beeps
set scrolloff=3                 " keep lines visiable when at buffers edge
set splitbelow                  " open splits below
set splitright                  " and vsplits to the right
set statusline=\ %<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
set title
set titleold=""
set titlestring=%F

set history=1000                " sizable memory
set backup                      " enable backups
set backupdir=~/.vim/backup     " back it up somewhere
set directory=~/.vim/backup     " ditto
set undodir=~/.vim/backup       " ditto
set undofile
set undolevels=1000
set undoreload=10000

set nowrap                      " no wrap for text
set textwidth=78                " wrap long lines at 80 chars
set colorcolumn=80              " highlight column
set ruler                       " show cursor position
set number                      " line numbers
set numberwidth=5               " line numbers column width
set laststatus=2                " always show status line
set cmdheight=1                 " command line height
set showcmd                     " display incomplete commands
set wildmode=longest,list       " tab completion similar to shell
set wildignore+=**/dist,**/bower_components,**/node_modules,tmp,docker_data,build

" highlight ColorColumn ctermbg=242

set suffixesadd=.rb
set path+=lib/**,test/**,app/**,spec/**
let g:ruby_path = &path

set autoindent                  " like a robot
set expandtab                   " use spaces in place of tabs
set tabstop=2                   " space(s) when tabbing
set shiftwidth=2                " space(s) for indentation
set softtabstop=2               " space(s) when tabbing always
set smarttab                    " backspacing deletes space-expanded tabs
set nojoinspaces                " do not use spaces when doing a line join
set backspace=indent,eol,start  " allow backspacing over everything
set list                        " display unprintable characters
set listchars=tab:\|\ ,trail:·,extends:>,precedes:<,nbsp:·

set foldmethod=manual           " turn off folds
set nofoldenable                " dito

set showmatch                   " show matching brackets, and parans
set hlsearch                    " highlight search results
set incsearch                   " highlight matches while searching
set ignorecase                  " ignore case when searching
set smartcase                   " override ignorecase if query has uppercase

set relativenumber

" set t_Co=256
syntax on
" colorscheme default

" highlight CursorLineNr ctermbg=11 ctermfg=03
" highlight NonText ctermbg=NONE ctermfg=10
" highlight SpecialKey ctermbg=00 ctermfg=10
" highlight ExtraWhitespace ctermbg=01 ctermfg=00

" set background=light
" highlight ColorColumn ctermbg=255
" " set background=dark
" " highlight ColorColumn ctermbg=233

" match ExtraWhitespace /\s\+$/
" autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
" autocmd InsertLeave * match ExtraWhitespace /\s\+$/
" autocmd BufWinLeave * call clearmatches()

let mapleader=","  " fearless leader

command! W :w      " alias W as w
command! Q :q      " alias Q as q
command! Ccl :ccl  " alias Ccl as ccl
command! Bd :bd  " alias Bd as bd

" use Q instead of Ex mode
map Q gq

" less escaping for regex searches
nnoremap / /\v
vnoremap / /\v

" clear search highlight
nnoremap <CR> :nohlsearch<cr>

" disable cursor keys in normal mode
map <Left>  <nop>
map <Right> <nop>
map <Up>    <nop>
map <Down>  <nop>

" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" disable help
nnoremap <F1> <nop>
inoremap <F1> <nop>

" easier splits
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>w :set invwrap wrap?<CR>

" switch between last two buffers
nnoremap <leader><leader> <c-^>

" expand parenthesis/bracket/quote
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>

" wrap parenthesis/bracket/quote
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i
inoremap $t <><esc>i

set grepprg=rg\ --vimgrep
let g:fzf_layout = { 'down': '~33%' }

nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>r :Rg<CR>

" rust
let g:rustfmt_autosave = 1

" jsx in js
let g:jsx_ext_required = 0

" a.l.e.
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_sign_column_always = 1
let g:ale_lint_on_text_change = 'never'
let g:ale_line_on_enter = 0
let g:ale_fixers = {
      \ 'javascript': [ 'prettier_standard' ],
      \ 'ruby': ['rubocop'],
      \ 'rust': ['rustfmt'],
      \ 'lua': ['prettier']
      \ }
let g:ale_linters = {
      \ 'cs': ['OmniSharp'],
      \ 'javascript': [''],
      \ 'ruby': ['rubocop'],
      \ 'rust': ['cargo'],
      \ 'lua': ['prettier']
      \ }
nmap <leader>1 <Plug>(ale_fix)
nmap <silent> gd :ALEGoToDefinition<CR>
nmap <silent> gh :ALEHover<CR>
" highlight ALEWarning ctermbg=DarkMagenta guibg=DarkMagenta
" highlight ALEWarning ctermbg=none cterm=underline
" highlight ALEError ctermbg=none cterm=underline
" highlight clear ALEError
" highlight clear ALEWarning
" highlight ALEErrorSign ctermfg=red ctermbg=none guifg=#000000 guibg=#000000
" highlight ALEWarningSign ctermfg=yellow ctermbg=none guifg=#000000 guibg=#000000
" highlight ALEError ctermbg=none ctermfg=196
" highlight ALEWarning ctermbg=none ctermfg=196
" hi link ALEErrorSign    ALEError
" hi link ALEWarningSign  ALEWarning
hi link ALEError ALEErrorSign
hi link ALEWarning ALEWarningSign

augroup Vim
  autocmd!

  " reload vimrc after saving
  autocmd BufWritePost ~/.vimrc so ~/.vimrc

  " create the directory if it doesn't exist
  autocmd BufNewFile * silent !mkdir -p $(dirname %)

  " open to last known cursor position
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Rakefile and Gemfile are Ruby
  autocmd BufRead,BufNewFile {Gemfile,Rakefile,config.ru} set ft=ruby

augroup END

augroup SizeWindow
  autocmd!
  autocmd WinEnter * call SizeWindow()
augroup END

function! SizeWindow()
  if winwidth(winnr()) < 78
    exec "vertical resize 78"
  end
endfunction

" tab autocompletion or indentation depending on context
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction

nmap <silent> <leader>T :TestNearest<CR>
nmap <silent> <leader>t :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

" test using dispatch.vim
let test#strategy = "dispatch"
let test#javascript#mocha#options = '-R spec --compilers js:babel-core/register'

" promote declaration to rspec let
command! PromoteToLet :call PromoteToLet()
map <leader>ll :PromoteToLet<cr>

function! PromoteToLet()
  :normal! dd
  " :exec '?^\s*it\>'
  :normal! P
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  :normal ==
endfunction

" strip trailing whitespace (,ss)
noremap <leader>ss :call StripWhitespace()<CR>

function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction

" rename current file
map <leader>sa :call RenameFile()<cr>

function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'))
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
