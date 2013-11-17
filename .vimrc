" {{{ Set up Vundle
    set nocompatible              " be iMproved
    filetype on                 " required!

    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()

    filetype plugin indent on     " required!


    " Use local bundles if available
    if filereadable(expand("~/.vimrc.bundles"))
        source ~/.vimrc.bundles
    endif
" }}}


" {{{ Basic interface settings: colors and stuff

    if !has('gui')
        "set term=$TERM          " Make arrow and other keys work
    endif
    set t_Co=256
    set background=dark
    "colorscheme codeschool       " Color scheme - override it below for GTK version
    filetype plugin indent on    " Detect file types
    syntax on                    " Syntax highlighting
    syntax sync minlines=500     " Limit for highlighting, performance tweak
    set mousehide                " Hide mouse while typing
    scriptencoding utf-8

    set clipboard=unnamedplus    " On GNU/Linux, use the + register for shared clipboard
    
    set shortmess+=filmnrxoOtT   " Short message format
    set viewoptions=folds,options,cursor,unix,slash  " Steve used it, seems good, I got it too
    set history=1000             " Override default history size (20)
    set hidden                   " Allow leaving buffer w/out 

" }}}
" {{{ Configure VIM UI
    set showmode                 " Display current mode
    set cursorline               " Highlight current line
    if has('cmdline_info')
        set ruler                " Show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
    set showcmd              " Show typed characters
    endif
    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\     " Filename
        set statusline+=%w%h%m%r " Options
        set statusline+=%{fugitive#statusline()} "  Git Hotness
        set statusline+=\ [%{&ff}/%Y]            " filetype
        set statusline+=\ [%{getcwd()}]          " current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set backspace=indent,eol,start    " Easier backspace
    set linespace=0                   " No space between rows
    set nu                            " Turn on the line numbers
    set showmatch                     " Highlight matching brackets
    set incsearch                     " Enable incremental search
    set hlsearch                      " highlight search terms
    set winminheight=0                " Windows of 0 height are allowed
    set ignorecase                    " Turn off case sensitive search
    set smartcase                     " ...
    set wildmenu                      " List variants, don't autocomplete
    set wildmode=list:longest,full    " Wildmenu settings
    set whichwrap=b,s,h,l,<,>,[,]     " Wrap, wrap everywhere!
    set scrolljump=5                  " Lines to scroll when cursor leaves the screen
    set scrolloff=3                   " Minimum lines to keep visible as line context
    set foldenable                    " Automatically fold code
    set foldmethod=marker             " Default to marker folding method
    set nolist
    set listchars=tab:,.,trail:.,extends:#,nbsp:. " Highlight problematic whitespace

    autocmd InsertEnter * :set number
    au FocusLost * :set number
    au FocusGained * :set relativenumber

    let loaded_matchparen = 1
    syn match Normal '>'

    set matchtime=1                   " 
    let b:match_debug=1               " For some reason, matchit was broken without this
    
    set colorcolumn=81                " highlight at 80 characters
    hi ColorColumn ctermbg=233        " Column color
    hi clear CursorLine
    hi CursorLine term=underline cterm=underline

    hi Search cterm=NONE ctermfg=black ctermbg=darkgray " Hijack search results colors
    hi Search ctermbg=233 ctermbg=253 " 

    " Go back to last used line in opened file
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

" }}}
" {{{ GUI Settins
    if has('gui_running')
        set guioptions-=T           " remove the toolbar
        set lines=40                " 40 lines of text instead of 24,
        set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
        set guioptions-=m           " Remove the menu
        set guioptions-=r           " 
        set guioptions-=L           " 
        set guioptions+=c           " Enable console dialogs instead of GTK
        colorscheme codeschool      " Color scheme for GUI mode
        hi Search guifg=black guibg=darkgray
    endif
" }}}

" {{{ Formatting
    set nowrap                      " wrap long lines
    set autoindent                  " indent at the same level of the previous line
    set shiftwidth=4                " use indents of 4 spaces
    set expandtab                   " tabs are spaces, not tabs
    set tabstop=4                   " an indentation every four columns
    set softtabstop=4               " let backspace delete indent
    set matchpairs+=<:>                " match, to be used with %
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
    set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
    " Remove trailing whitespaces and ^M chars
    autocmd FileType c,cpp,java,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> call StripTrailingWhitespace()
    autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
" }}}

" {{{ Set directories
    set backup                   " Enable backups
    if has('persistent_undo')
        set undofile
    set undolevels=1000
    set undoreload=10000
    endif
" }}}

" {{{ Key mappings

    let mapleader = ','          " Leader is comma (,) character

    " Wrapped lines goes down/up to next row, rather than next line in file.
    nnoremap j gj
    nnoremap k gk

    " Shift key fixes
    command! -bang -nargs=* -complete=file E e<bang> <args>
    command! -bang -nargs=* -complete=file W w<bang> <args>
    command! -bang -nargs=* -complete=file Wq wq<bang> <args>
    command! -bang -nargs=* -complete=file WQ wq<bang> <args>
    command! -bang Wa wa<bang>
    command! -bang WA wa<bang>
    command! -bang Q q<bang>
    command! -bang QA qa<bang>
    command! -bang Qa qa<bang>

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$
    " Clear highlighted search
    nmap <silent> <leader>/ :nohlsearch<CR>

    " {{{ Shortcuts
        " Change Working Directory to that of the current file
        cmap cwd lcd %:p:h
        cmap cd. lcd %:p:h

        " visual shifting (does not exit Visual mode)
        vnoremap < <gv
        vnoremap > >gv
        
        " For when you forget to sudo.. Really Write the file.
        cmap w!! w !sudo tee % >/dev/null

        " map <Leader>ff to display all lines with keyword under cursor
        " and ask which one to jump to
        nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

        " C-R fires up a s/<word under cursor>/<enter replacement>/gc
        vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

        " Ported those from old config, but I can't recall using them
        nnoremap <C-W>O :call MaximizeToggle ()<CR>
        nnoremap <C-W>o :call MaximizeToggle ()<CR>
        nnoremap <C-W><C-O> :call MaximizeToggle ()<CR>

        " Random custom crap, feel free to nuke them
        nnoremap <Leader>w :cd /srv/http<CR>
        silent! vunmap <Esc>[H
        silent! vunmap <Esc>[F
        silent! nunmap <Esc>[H
        silent! nunmap <Esc>[F
        silent! iunmap <Esc>[H
        silent! iunmap <Esc>[F
        silent! unmap <Esc>[H
        silent! unmap <Esc>[F

        " Control + arrows switch window
        nnoremap <silent> <C-Right> <c-w>l
        nnoremap <silent> <C-Left> <c-w>h
        nnoremap <silent> <C-Up> <c-w>k
        nnoremap <silent> <C-Down> <c-w>j

        " Faster resize windows
        map <silent> <C-h> 5<C-w><
        map <silent> <C-l> 5<C-w>>

        " Various useful shortcuts
        nnoremap <silent> <F3> :Grep<CR> 
        nnoremap <silent> <F10> :GundoToggle<CR> 
        nnoremap <silent> <C-T> :TagbarToggle<CR>
        nnoremap <Leader><F11> :SyntasticToggleMode
        nnoremap <C-Z> :Bufferlistsw<CR>

    " }}}
" }}}

"{{{ spf13 original functions

    function! UnBundle(arg, ...)
      let bundle = vundle#config#init_bundle(a:arg, a:000)
      call filter(g:bundles, 'v:val["name_spec"] != "' . a:arg . '"')
    endfunction

    com! -nargs=+         UnBundle
    \ call UnBundle(<args>)

    function! InitializeDirectories()
        let separator = "."
        let parent = $HOME
        let prefix = '.vim'
        let dir_list = {
                    \ 'backup': 'backupdir',
                    \ 'views': 'viewdir',
                    \ 'swap': 'directory' }

        if has('persistent_undo')
            let dir_list['undo'] = 'undodir'
        endif

        for [dirname, settingname] in items(dir_list)
            let directory = parent . '/' . prefix . dirname . "/"
            if exists("*mkdir")
                if !isdirectory(directory)
                    call mkdir(directory)
                endif
            endif
            if !isdirectory(directory)
                echo "Warning: Unable to create backup directory: " . directory
                echo "Try: mkdir -p " . directory
            else
                let directory = substitute(directory, " ", "\\\\ ", "g")
                exec "set " . settingname . "=" . directory
            endif
        endfor
    endfunction
    call InitializeDirectories()

    function! NERDTreeInitAsNeeded()
        redir => bufoutput
        buffers!
        redir END
        let idx = stridx(bufoutput, "NERD_tree")
        if idx > -1
            NERDTreeMirror
            NERDTreeFind
            wincmd l
        endif
    endfunction

    " Strip whitespace
    function! StripTrailingWhitespace()
        " To disable the stripping of whitespace, add the following to your
        " .vimrc.local file:
        "   let g:spf13_keep_trailing_whitespace = 1
        if !exists('g:spf13_keep_trailing_whitespace')
            " Preparation: save last search, and cursor position.
            let _s=@/
            let l = line(".")
            let c = col(".")
            " do the business:
            %s/\s\+$//e
            " clean up: restore previous search history, and cursor position
            let @/=_s
            call cursor(l, c)
        endif
    endfunction
"}}}
"{{{ Custom functions
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
"}}}

"{{{ Plugin settings
    "{{{ PIV
        let g:DisableAutoPHPFolding = 0
        let g:PIVAutoClose = 0
    "}}}
    "{{{ Misc
        let g:NERDShutUp=1
        let b:match_ignorecase = 1

        " Documentation block templates and hotkey
        let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates"
        nnoremap <buffer> <Leader>p :call pdv#DocumentCurrentLine()<CR>
        let g:ctrlp_follow_symlinks = 2
        let g:EclimCompletionMethod = 'omnifunc'
        autocmd Filetype php setlocal omnifunc=eclim#php#complete#CodeComplete
        set completeopt-=preview
        let g:ycm_add_preview_to_completeopt=0

    "}}}
    "{{{ NerdTree
        map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
        map <leader>e :NERDTreeFind<CR>
        nmap <leader>nt :NERDTreeFind<CR>

        let NERDTreeShowBookmarks=0
        let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
        let NERDTreeChDirMode=0
        let NERDTreeQuitOnOpen=0
        let NERDTreeMouseMode=2
        let NERDTreeShowHidden=1
        let NERDTreeKeepTreeInNewTab=1
        let g:nerdtree_tabs_open_on_gui_startup=0
    "}}}
    "{{{ Tabularize
        nmap <Leader>a= :Tabularize /=<CR>
        vmap <Leader>a= :Tabularize /=<CR>
        nmap <Leader>a: :Tabularize /:<CR>
        vmap <Leader>a: :Tabularize /:<CR>
        nmap <Leader>a:: :Tabularize /:\zs<CR>
        vmap <Leader>a:: :Tabularize /:\zs<CR>
        nmap <Leader>a, :Tabularize /,<CR>
        vmap <Leader>a, :Tabularize /,<CR>
        nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
        vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
     "}}}
     "{{{ Indent_guides
        set ts=4 sw=4 et
        let g:indent_guides_start_level = 2
        let g:indent_guides_guide_size = 1
        let g:indent_guides_enable_on_vim_startup = 1
        let g:indent_guides_auto_colors = 0
        autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=233
        autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=232
     "}}}
     "{{{ Redmine integration
        " let g:redmine_auth_site = ''
        " let g:redmine_auth_key  = ''
        " let g:redmine_author_id = ''
        " let g:redmine_project_id = ''
     "}}}
     "{{{ Airline config
        let g:airline_symbols = {}
        let g:airline_left_sep = '⮀'
        let g:airline_left_alt_sep = '⮁'
        let g:airline_right_sep = '⮂'
        let g:airline_right_alt_sep = '⮃'
        let g:airline_symbols.branch = '⭠'
        let g:airline_symbols.readonly = '⭤'
        let g:airline_symbols.linenr = '⭡'

        let g:airline_theme='bubblegum'
        let g:airline_powerline_fonts = 1
     "}}}
"}}}
