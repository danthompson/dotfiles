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
set cmdheight=2                 " command line height
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

function! RunRuby()
  " Write the file and run tests for the given filename
  w
  silent !echo;echo;echo;echo;echo
  exec ":!ruby " . expand("%")
endfunction

function! RunTestFile()
  let in_spec_file    = match(expand("%"), '_spec.rb$') != -1
  let in_test_file    = match(expand("%"), '_test.rb$') != -1
  let in_feature_file = match(expand("%"), '.feature$') != -1

  if in_spec_file
    call SetTestFile()
  elseif in_test_file
    call SetTestFile()
  elseif in_feature_file
    call SetTestFile()
  elseif !exists("g:grb_test_file")
    return
  end

  call ChooseTestRunner(g:grb_test_file)
endfunction

function! SetTestFile()
  " Set the spec file that tests will be run for.
  let g:grb_test_file=@%
endfunction

function! ChooseTestRunner(filename)
  write
  silent !echo;echo;echo;echo;echo

  let run_specs   = match(a:filename, '_spec.rb$') != -1
  let run_tests   = match(a:filename, '_test.rb$') != -1
  let run_feature = match(a:filename, '.feature$') != -1

  if run_specs
    call RunSpecs(a:filename)
  elseif run_tests
    call RunTests(a:filename)
  elseif run_feature
    call RunFeature(a:filename)
  endif
endfunction

" \:<C-R>=line(".")
function! RunSpecs(filename)
  silent exec ":!echo rspec " . a:filename
  " exec ":!ruby -Ilib -Ispec " . a:filename
  exec ":!time bundle exec rspec " . a:filename
endfunction

function! RunTests(filename)
  silent exec ":!echo ruby -Itest -Ilib " . a:filename
  exec ":!time bundle exec ruby -Itest -Ilib " . a:filename
endfunction

function! RunFeature(filename)
  silent exec ":!echo bundle exec cucumber -r features " . a:filename
  " exec ":!ruby -Ilib -Ispec " . a:filename
  exec ":!time bundle exec cucumber -r features " . a:filename
endfunction

nmap <leader>. :call RunTestFile()<CR>


" " run this test file
" map <leader>t :call RunTestFile()<cr>

" " run only the example under the cursor
" map <leader>T :call RunNearestTest()<cr>

" " run all test files 
" map <leader>a :call RunTests('spec')<cr>

" " spec running helpers
" function! RunTests(filename)
"   " Write the file and run tests for the given filename
"   :w
"   :silent !echo;echo;echo;echo;echo
"   exec ":!bundle exec rspec " . a:filename
" endfunction
" function! SetTestFile()
"   " Set the spec file that tests will be run for.
"   let t:grb_test_file=@%
" endfunction
" function! RunTestFile(...)
"   if a:0
"     let command_suffix = a:1
"   else
"     let command_suffix = ""
"   endif
"   " Run the tests for the previously-marked file.
"   let in_spec_file = match(expand("%"), '_spec.rb$') != -1
"   if in_spec_file
"     call SetTestFile()
"   elseif !exists("t:grb_test_file")
"     return
"   end
"   call RunTests(t:grb_test_file . command_suffix)
" endfunction
" function! RunNearestTest()
"   let spec_line_number = line('.')
"   call RunTestFile(":" . spec_line_number)
" endfunction

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
