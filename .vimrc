set nocompatible                " vim settings over vi

call pathogen#infect()          " load pathogen bundles
call pathogen#helptags()        " and friends

set shell=bash                  " magic allows rvm support

set encoding=utf-8              " utf-8
set hidden                      " backgrounding buffers, remember marks/undos
set clipboard=unnamed           " link vim and system clipboard
set visualbell                  " no beeps
set t_vb=                       " really no beeps
set showmatch                   " show matching brackets, and parans
set scrolloff=3                 " keep lines visiable when at buffers edge

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
set cursorline                  " highlight line cursor is on
set colorcolumn=80              " highlight column
set ruler                       " show cursor position
set number                      " line numbers
set numberwidth=5               " line numbers column width
set laststatus=2                " always show status line
set cmdheight=1                 " command line height
set showcmd                     " display incomplete commands
set wildmode=longest,list       " tab completion similar to shell
set splitbelow                  " open splits below
set splitright                  " and vsplits to the right

set hlsearch                    " highlight search results
set incsearch                   " highlight matches while searching
set ignorecase                  " ignore case when searching
set smartcase                   " override ignorecase if query has uppercase

set autoindent                  " like a robot
set expandtab                   " use spaces place of tabs
set tabstop=2                   " space(s) when tabbing
set shiftwidth=2                " space(s) for indentation
set softtabstop=2               " space(s) when tabbing always
set smarttab                    " backspacing deletes space-expanded tabs
set nojoinspaces                " do not use spaces when doing a line join
set backspace=indent,eol,start  " allow backspacing over everything

set list                        " display unprintable characters
set listchars=tab:\|\ ,trail:·,extends:>,precedes:<,nbsp:·


syntax on
colorscheme base16-default      " ...
set background=dark             " ...

" status layout
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
set title
set titleold=""
set titlestring=%F              " file path

if has("gui_running")           " GUI options

  set lines=100                 " window dimensions
  set columns=171               " ditto
  set go-=T                     " hide toolbar
  set guioptions-=L             " hide scrollbar
  set guioptions-=r             " ditto
  set guioptions=aAce           " ditto

endif

" alias W/Q to w/q for sanity
command! W :w
command! Q :q

" map leader
let mapleader=","

" use Q instead of Ex mode
map Q gq

" less escaping for regex searches
nnoremap / /\v
vnoremap / /\v

" clear search highlight
nnoremap <CR> :nohlsearch<cr>

" disable backspace to force use of <C-h> and <C-w>
inoremap <bs> <nop>

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

nnoremap <leader>v :vsplit<CR>
nnoremap <leader>w :set invwrap wrap?<CR>

" switch between last two buffers
nnoremap <leader><leader> <c-^>

" parenthesis/bracket expanding
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>

" auto complete of (, ", ', [
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i
inoremap $t <><esc>i

" command-t as f
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
let g:CommandTMaxHeight=20

" highlights
highlight CursorLineNr ctermbg=11 ctermfg=13
highlight NonText ctermbg=00 ctermfg=10
highlight SpecialKey ctermbg=00 ctermfg=10
highlight ExtraWhitespace ctermbg=01 ctermfg=00

" match extra white space and highlight
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

augroup Vim
  autocmd!

  " enable file type detection and load indent files
  filetype plugin indent on

  " reload vimrc after saving
  autocmd BufWritePost ~/.vimrc so ~/.vimrc

  " create the directory if it doesn't exist
  autocmd BufNewFile * silent !mkdir -p $(dirname %)

  " open to last known cursor position
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
  autocmd BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} set ft=ruby

  autocmd FileType ruby setlocal foldmethod=syntax
  autocmd FileType java setlocal foldmethod=syntax
  autocmd FileType xml setlocal foldmethod=syntax

augroup END

" spell check for filetypes
autocmd BufRead,BufNewFile *.md setlocal spell spelllang=en_us syntax=markdown
autocmd BufRead,BufNewFile *.txt setlocal spell spelllang=en_us
autocmd FileType gitcommit setlocal spell spelllang=en_us

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

" configure vroom
let g:vroom_map_keys = 0
let g:vroom_use_colors = 1
let g:vroom_clear_screen = 0
let g:vroom_write_all = 1
let g:vroom_test_unit_command = 'm'

map <leader>t :call vroom#RunTestFile()<cr>
map <leader>T :call vroom#RunNearestTest()<cr>

" promote declaration to let
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

" open changed files
command! OpenChangedFiles :call OpenChangedFiles()
noremap <leader>oc :call OpenChangedFiles()<CR>
function! OpenChangedFiles()
  only " Close all windows, unless they're modified
  let status = system('git status -s | grep "^ \?\(M\|A\)" | cut -d " " -f 3')
  let filenames = split(status, "\n")
  exec "edit " . filenames[0]
  for filename in filenames[1:]
    exec "sp " . filename
  endfor
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

set foldlevelstart=0
let xml_syntax_folding=1

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" Make zO recursively open whatever fold we're in, even if it's partially open.
nnoremap zO zczO
