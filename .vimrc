" based on http://github.com/jferris/config_files/blob/master/vimrc

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My bundles here:
"
" original repos on GitHub
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-rails.git'
Bundle 'tpope/vim-rake.git'
Bundle 'tpope/vim-bundler.git'
Bundle 'tpope/vim-repeat'
Bundle 'vim-ruby/vim-ruby'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'mattn/emmet-vim'
Bundle 'godlygeek/tabular'
Bundle 'vim-scripts/tComment'
Bundle 'myusuf3/numbers.vim'
Bundle 'sickill/vim-monokai'
" snip mate and it's dependencyes
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"
" Optional:
Bundle "honza/vim-snippets"

" vim-misk is needed by vim-easytags
Bundle 'xolox/vim-misc'
" UnBundle 'xolox/vim-easytags'
Bundle 'taglist.vim'
Bundle 'majutsushi/tagbar'
Bundle 'Shougo/neocomplete.vim'
Bundle 'vim-scripts/EasyGrep'
"UnBundle 'jaredly/vim-debug'
Bundle 'rking/ag.vim'
Bundle 'bling/vim-airline'
Bundle 'Shougo/unite.vim'
Bundle 'tsukkee/unite-help'
Bundle 'thinca/vim-unite-history'
Bundle 'Shougo/unite-outline'
Bundle 'scrooloose/nerdtree'
Bundle 'rodjek/vim-puppet'
" Bundle 'Shougo/vimproc.vim'

" spf13 bundles
    " UnBundle 'spf13/PIV'
    Bundle 'rayburgemeestre/phpfolding.vim'
    Bundle 'python.vim'
    Bundle 'pythoncomplete'
    Bundle 'klen/python-mode'
    Bundle 'elzr/vim-json'
    Bundle 'pangloss/vim-javascript'
    Bundle 'groenewege/vim-less'
    Bundle 'hail2u/vim-css3-syntax'
    Bundle 'gorodinskiy/vim-coloresque'
    Bundle 'tpope/vim-markdown'
    Bundle 'spf13/vim-preview'
    Bundle 'beyondwords/vim-twig'
    Bundle 'scrooloose/nerdcommenter'
    Bundle 'terryma/vim-multiple-cursors'
    Bundle 'mbbill/undotree'
    Bundle 'nathanaelkane/vim-indent-guides'
    Bundle 'vim-scripts/restore_view.vim'
    Bundle 'dhruvasagar/vim-dotoo'

Bundle 'sandeepcr529/Buffet.vim'
Bundle 'Shougo/neomru.vim'
Bundle 'godlygeek/csapprox'

Bundle 'flazz/vim-colorschemes'

Bundle 'maksimr/vim-jsbeautify'

" UnBundle 'Yggdroot/indentLine'
Bundle 'mikewest/vimroom'

Bundle 'xsbeats/vim-blade'
Bundle 'kurkale6ka/vim-pairs'
Bundle 'szw/vim-ctrlspace'

" vim-scripts repos
Bundle 'L9'

Bundle 's3rvac/AutoFenc'
Plugin 'dsawardekar/ember.vim'
Bundle 'dsawardekar/portkey'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'malithsen/trello-vim'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'vim-visual-increment'

nnoremap <C-x> :Bufferlistsw<CR>

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set undofile                " Save undo's after file closes
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

set nobackup
set noswapfile
set nowritebackup
set history=1000		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set cursorline

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp


  set t_Co=256
if $COLORTERM == 'gnome-terminal' || $TERM == 'xterm' || $TERM == 'screen'
  set t_Co=256
endif

if $COLORTERM == 'drop-down-terminal'
  " set t_Co=256
  colorscheme nightsh
else
  " Color scheme
  "colorscheme monokai
  colorscheme nightsh
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
  set hlsearch
endif

if (has("gui_running"))
  colorscheme flattown
endif

" Switch wrap off for everything
set nowrap

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Set File type to 'text' for files ending in .txt
  autocmd BufNewFile,BufRead *.txt setfiletype text

  " Enable soft-wrapping for text files
  autocmd FileType text,markdown,html,xhtml,eruby,mail setlocal wrap linebreak nolist tw=79 formatoptions+=t

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  " autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Automatically load .vimrc source when saved
  autocmd BufWritePost .vimrc source $MYVIMRC

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" if has("folding")
  " set foldenable
  " set foldmethod=syntax
  " set foldlevel=1
  " set foldnestmax=2
  " set foldtext=strpart(getline(v:foldstart),0,50).'\ ...\ '.substitute(getline(v:foldend),'^[\ #]*','','g').'\ '
" endif

" Softtabs, 2 spaces
set softtabstop=2
set tabstop=2
set shiftwidth=2
set expandtab

" Always display the status line
set laststatus=2

" let g:airline_theme='powerlineish'
" let g:airline_left_sep = '⮀'
" let g:airline_left_alt_sep = '⮁'
" let g:airline_right_sep = '⮂'
" let g:airline_right_alt_sep = '⮃'
" let g:airline_branch = '⭠'
" let g:airline_readonly = '⭤'
" let g:airline_linenr = '⭡'

let g:airline_powerline_fonts = 1
" let g:airline#extensions#tabline#enabled = 1

" Edit the README_FOR_APP (makes :R commands work)
" map <Leader>R :e doc/README_FOR_APP<CR>

" Leader shortcuts for Rails commands
" map <Leader>m :Rmodel 
" map <Leader>c :Rcontroller 
" map <Leader>v :Rview 
" map <Leader>u :Runittest 
" map <Leader>f :Rfunctionaltest 
" map <Leader>f :FufFile<CR>
" map <Leader>tm :RTmodel 
" map <Leader>tc :RTcontroller 
" map <Leader>tv :RTview 
" map <Leader>tu :RTunittest 
" map <Leader>tf :RTfunctionaltest 
" map <Leader>sm :RSmodel 
" map <Leader>sc :RScontroller 
" map <Leader>sv :RSview 
" map <Leader>su :RSunittest 
" map <Leader>sf :RSfunctionaltest 

" Hide search highlighting
map <Leader>H :set invhls <CR>

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Duplicate a selection
" Visual mode: D
vmap D y'>p

" Press Shift+P while in visual mode to replace the selection without
" overwriting the default register
vmap P p :call setreg('"', getreg('0')) <CR>

" For Haml
au! BufRead,BufNewFile *.haml         setfiletype haml

" No Help, please
nmap <F1> <Esc>

" Press ^F from insert mode to insert the current file name
imap <C-F> <C-R>=expand("%")<CR>

" Maps autocomplete to tab
" imap <Tab> <C-N>

imap <C-L> <Space>=><Space>

" Display extra whitespace
" set list listchars=tab:»·,trail:·

" Edit routes
command! Rroutes :e config/routes.rb
command! Rschema :e db/schema.rb

" Local config
if filereadable(".vimrc.local")
  source .vimrc.local
endif

" Use Ack instead of Grep when available
if executable("ack")
  set grepprg=ack\ -H\ --nogroup\ --nocolor\ --ignore-dir=tmp\ --ignore-dir=coverage
endif


" Numbers
set number
set numberwidth=5

" Snippets are activated by Shift+Tab
let g:snippetsEmu_key = "<S-Tab>"

" Tab completion options
" (only complete to the longest unambiguous match, and show a menu)
set completeopt=longest,menu
set wildmode=list:longest,list:full
set complete=.,t

" case only matters with mixed case expressions
set ignorecase
set smartcase

" Tags
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"
set tags=./tags;

" Write file
nnoremap ZW :w<CR>

" set the system cliboard as the default yank source                                                                                                                                                                                      
set clipboard=unnamedplus 

" Minimize and maximize
nnoremap <C-W>O :call MaximizeToggle()<CR>
nnoremap <C-W>o :call MaximizeToggle()<CR>
nnoremap <C-W><C-O> :call MaximizeToggle()<CR>
function! MaximizeToggle()
  if exists("s:maximize_session")
    exec "source " . s:maximize_session
    call delete(s:maximize_session)
    unlet s:maximize_session
    let &hidden=s:maximize_hidden_save
    unlet s:maximize_hidden_save
  else
    let s:maximize_hidden_save = &hidden
    let s:maximize_session = tempname()
    set hidden
    exec "mksession! " . s:maximize_session
    only
  endif
endfunction

" Ag.vim script for easy search
function! SilverSearch(word)
  let @s = expand(a:word)
  let l:ag_cmd = "Ag " . shellescape(@s) . " ."
  call histadd("cmd", l:ag_cmd)
  set hidden
  execute l:ag_cmd
endfunction

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  " Overwrite settings.
  imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  imap <silent><buffer><expr> <C-p> unite#do_action('split')
endfunction

" silver searcher
let g:agprg="ag --column"

" copy the default clipboard into the system clipboard
map <Leader>= :let @+=@"<CR>

" You complete me disabled for tab, only for control space
" let g:ycm_auto_trigger = 0
let g:ycm_key_list_select_completion = ['<C-j>', '<C-Space>']
let g:ycm_key_list_previous_completion = ['<C-k']

" Remap tab to snip mate
" imap <Tab> <Plug>snipMateNextOrTrigger
" smap <Tab> <Plug>snipMateNextOrTrigger

" numbers do not show for Control+C, they show only for Esc
map <C-C> <ESC>
" search with ag for the content of register s
map <Leader><leader>a :call SilverSearch("<cword>")<CR>
map <Leader><leader>A :call SilverSearch("<cWORD>")<CR>

" Unite.vim
nnoremap <Leader><Leader>p :Unite -start-insert buffer file_mru file_rec -no-split<CR>
nnoremap <Leader><Leader>l :Unite -start-insert line -auto-preview -vertical<CR>
nnoremap <Leader><Leader>m :Unite -start-insert mapping -no-split<CR>
nnoremap <Leader><Leader>c :Unite -buffer-name=commands -default-action=execute history/command command -start-insert -no-split<CR>
nnoremap <Leader><Leader>h :Unite -start-insert -no-split help<CR>
nnoremap <Leader><Leader>o :Unite -start-insert -no-split outline<CR>
nnoremap <Leader><Leader>o :Unite -start-insert -no-split outline<CR>
nnoremap <Leader><Leader>r :%S/<C-R>s/<C-R>s/gc
nnoremap <Leader>g :Gstatus<CR>
nnoremap <C-W>x :only<CR>


if exists(":Tabularize")
  nmap <Leader>a= :Tab /=<CR>
  vmap <Leader>a= :Tab /=<CR>
  nmap <Leader>a: :Tab /:\zs<CR>
  vmap <Leader>a: :Tab /:\zs<CR>
  nmap <Leader>a^ :Tab /^\zs<CR>
  vmap <Leader>a^ :Tab /^\zs<CR>
endif


" ******************************************************************
" Stuff copied from spf13

highlight clear SignColumn      " SignColumn should match background
highlight clear LineNr          " Current line number row will have same background color in relative mode
set backspace=indent,eol,start  " Backspace for dummies
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set foldenable                  " Auto fold code
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

nnoremap <C-E> :NERDTreeToggle<CR>

    set nowrap                      " Do not wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=2                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=2                   " An indentation every four columns
    set softtabstop=2               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
      
    " Wrapped lines goes down/up to next row, rather than next line in file.
    noremap j gj
    noremap k gk
    
    " Same for 0, home, end, etc
    function! WrapRelativeMotion(key, ...)
        let vis_sel=""
        if a:0
            let vis_sel="gv"
        endif
        if &wrap
            execute "normal!" vis_sel . "g" . a:key
        else
            execute "normal!" vis_sel . a:key
        endif
    endfunction

    " Map g* keys in Normal, Operator-pending, and Visual+select (over written
    " below) modes
    noremap $ :call WrapRelativeMotion("$")<CR>
    noremap <End> :call WrapRelativeMotion("$")<CR>
    noremap 0 :call WrapRelativeMotion("0")<CR>
    noremap <Home> :call WrapRelativeMotion("0")<CR>
    noremap ^ :call WrapRelativeMotion("^")<CR>
    " Over write the Visual+Select mode mappings to ensure correct mode is
    " passed to WrapRelativeMotion
    vnoremap $ :<C-U>call WrapRelativeMotion("$", 1)<CR>
    vnoremap <End> :<C-U>call WrapRelativeMotion("$", 1)<CR>
    vnoremap 0 :<C-U>call WrapRelativeMotion("0", 1)<CR>
    vnoremap <Home> :<C-U>call WrapRelativeMotion("0", 1)<CR>
    vnoremap ^ :<C-U>call WrapRelativeMotion("^", 1)<CR>

    " Stupid shift key fixes
    command! -bang -nargs=* -complete=file E e<bang> <args>
    command! -bang -nargs=* -complete=file W w<bang> <args>
    command! -bang -nargs=* -complete=file Wq wq<bang> <args>
    command! -bang -nargs=* -complete=file WQ wq<bang> <args>
    command! -bang Wa wa<bang>
    command! -bang WA wa<bang>
    command! -bang Q q<bang>
    command! -bang QA qa<bang>
    command! -bang Qa qa<bang>
    cmap Tabe tabe
    nnoremap <Leader>s :w<CR>

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

        nmap <silent> <leader>/ :nohlsearch<CR>
        
    " Visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv
    
    " Allow using the repeat operator with a visual selection (!)
    " http://stackoverflow.com/a/8064607/127816
    vnoremap . :normal .<CR>

    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null

    " Easier horizontal scrolling
    map zl zL
    map zh zH

    set hidden

    
let mapleader = ","
nnoremap <Leader><Leader><Esc> :let mapleader=","<CR>

" Autocommand to reduce pending-operator delay in insert mode
augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=500
    au InsertLeave * set timeoutlen=1000
augroup END

inoremap jj <esc>
nnoremap <F5> :set cursorcolumn!<CR>

set laststatus=2
