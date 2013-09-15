"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" My current vimrc
" Feel free to grab what you like inside
" Gabriel AHTUNE <larchange[at]gmail.com>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" F3:  Toggle Color Column
" F4:  outline
" F6:  Gundo
" F7:  Cycle Spell checking
" F8:  Cope
" F9:  MRU
" F10: Explorer
" F12: Buffer list
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GENERAL: CONFIGURATION
" -----------------------------------------------------------------------------
    " Editor behaviour
        let mapleader = ","
        set nocompatible
        set noautochdir
        set backupdir=~/.vim/backup/
        set directory=~/.vim/backup/
        set encoding=utf-8
        set ffs=unix,dos,mac
        set autoread                  " read file when changed outside of Vim
        set whichwrap+=<,>,h,l,[,]
    " Display behaviour and features
        syntax on
        set gfn=Monaco
        set number
        set scrolloff=3
        set showcmd
        set ttyfast
        set term=rxvt-256color
        set ttymouse=urxvt
        set mouse=a
        set title
        set guioptions=""
        set wildmenu
        set list
        set listchars=tab:→⋅,trail:⋅,extends:↝,nbsp:⋅,precedes:↜,eol:¬
        set showbreak=↪
        set cmdwinheight=5
        set fillchars=""
        set shm=IflnxtToO
        au InsertEnter * set cul
        au InsertLeave * set nocul
    " Search
        set hlsearch
        set incsearch
        set ignorecase
        set smartcase " do not ignore case if search contains capitals
        set magic
        set showmatch
    " Fold
        set foldcolumn=3
        set foldmethod=indent
        set foldminlines=2
        set foldopen=block,hor,mark,percent,quickfix,search,tag,undo,jump
    " Indentation and flowing
        filetype indent on
        set expandtab " Use spaces instead of tabs
        set smarttab
        set shiftwidth=4 " 1 tab == 4 spaces
        set tabstop=4
        set ai "Auto indent
        set si "Smart indent
        set copyindent
        set nowrap "Wrap lines
        set tw=79
        set backspace=indent,eol,start
        set sidescroll=5 " slow side scroll
        nnoremap <silent> g= :let b:winview=winsaveview()<CR>gg=G:call winrestview(b:winview)<CR>
    " History
        set undolevels=1000
        set history=1000
        set undofile
        set undodir=/tmp
    " No annoying sound on errors
        set noerrorbells
        set novisualbell
        set t_vb=
        set tm=500
    " Others
        set virtualedit=block
        set tags=tags;

" LIBRARY: Useful functions
" -----------------------------------------------------------------------------
    " Just like windo, but restore the current window when done.
    function! WinDo(command)
        let currwin=winnr()
        execute 'windo ' . a:command
        execute currwin . 'wincmd w'
    endfunction
    com! -nargs=+ -complete=command Windo call WinDo(<q-args>)

    " Just like Windo, but disable all autocommands for super fast processing.
    com! -nargs=+ -complete=command Windofast noautocmd call WinDo(<q-args>)

    " Just like bufdo, but restore the current buffer when done.
    function! BufDo(command)
        let currBuff=bufnr("%")
        execute 'bufdo ' . a:command
        execute 'buffer ' . currBuff
    endfunction
    com! -nargs=+ -complete=command Bufdo call BufDo(<q-args>)

" MAPPING: Make Vim a bit more user friendly ...
" -----------------------------------------------------------------------------
    " General
        nnoremap <leader>sv :source $MYVIMRC<cr>
        cnoremap <leader>v $MYVIMRC
        nnoremap <Leader>l '0
        cnoremap w!! %!sudo tee > /dev/null %
        inoremap <C-u> <C-g>u<C-u>
        onoremap All :<C-u>normal! ggVG<CR>
        vnoremap All `<gg`>G

        function! MakeExecutable()
            if (strpart(getline(1), 0, 2) == '#!')
                silent !chmod +x %
            endif
        endfunction
        autocmd bufwritepost * call MakeExecutable()

        nnoremap <silent> <Leader>w :r !echo "\#\! `which <cword>`"<CR>k"_dd

        nnoremap <leader>rt :%s/\s\+$//g<CR>:nohl<CR>

    " Buffers
        set hidden " Do not need to save file when open a new file.
        nnoremap <Leader>b :enew<CR>
        map <Leader>x <ESC>:bd<CR>

    " Windows
        nnoremap <C-w>v <C-w>v<C-w>l
        noremap <C-w>s <C-w>s<C-w>j
        nnoremap <Leader>ss :Windo set scrollbind!<CR>

    " Tags
        map <Leader>ct :!/usr/bin/ctags -R .<CR>

    " Copy cut past and special paste
        set clipboard=unnamed
        map Y y$
        " paste with increasing number at the same time
        nnoremap <leader>p p<C-A>==yy

    " select just pasted content
        nnoremap <leader>v V`]

    " Kill line
        noremap <C-k> "_dd

    " Indentation
        vnoremap < <gv
        vnoremap > >gv
        nnoremap <tab> >>
        nnoremap <S-tab> <<

    " Fold
        nnoremap <space> za

    " Search
        nnoremap <silent> _ :let b:winview=winsaveview()<CR>*:call winrestview(b:winview)<CR>
        nnoremap <silent> <2-LeftMouse> <C-]>

    " Moving
        inoremap <S-Up>   <C-O>gk
        inoremap <S-Down> <C-O>gj
        noremap  <Up>   gk
        noremap  <Down> gj
        noremap <C-ScrollWheelUp> <ESC>zh
        noremap <C-ScrollWheelDown> <ESC>zl

    " Diff
        nnoremap <Leader>dd :vert diffsplit<space>
        nnoremap <Leader>dp :vert diffpatch<space>
        nnoremap <Leader>dw :Windo diffthis<CR>
        nnoremap <Leader>dx :Windo diffoff<CR>
        nnoremap <Leader>dt :diffthis<CR>
        nnoremap <Leader>do :diffoff<CR>
        nnoremap <Leader>du :diffupdate<CR>
        " Ignore space
        set diffopt+=iwhite

    " Spell check <F7>
        let g:myLang=0
        let g:myLangList=["nospell","en","fr"]
        function! ToggleSpell()
            let g:myLang=g:myLang+1
            if g:myLang>=len(g:myLangList) | let g:myLang=0 | endif
            if g:myLang==0
                set spelllang="en"
                setlocal nospell
            else
                execute "setlocal spell spelllang=".get(g:myLangList, g:myLang)
            endif
            echo "spell checking language:" g:myLangList[g:myLang]
        endfunction
        nmap <silent> <F7> :call ToggleSpell()<CR>

    " Toggle 80 column marker <F3>
        inoremap <F3> <ESC>:call ToggleColorColumn()<CR>a
        vnoremap <F3> <ESC>:call ToggleColorColumn()<CR>gv
        nnoremap <F3> <ESC>:call ToggleColorColumn()<CR>

        func! ToggleColorColumn()
            if exists("b:colorcolumnon") && b:colorcolumnon
                let b:colorcolumnon = 0
                exec ':set colorcolumn=0'
                echo (&tw + 1).' column marker off'
            else
                let b:colorcolumnon = 1
                exec ':set colorcolumn='.(&tw + 1)
                echo (&tw + 1).' column marker on'
            endif
        endfunc

    " Special Insert and modification
        " Insert Time
        nmap <Leader>ts aLast Modified: <C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR><Esc>

        " Insert Modeline
        function! AppendModeline()
            let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d :",
                        \ &tabstop, &shiftwidth, &textwidth)
            let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
            call append(line("$"), l:modeline)
        endfunction
        nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

    " Explorer
        nn <Leader>cd :lcd %:h<CR>:pwd<CR>
        nn <Leader>e :e .<CR>7G

    " Cope
        function! ToggleCope()
            if exists("t:cope_open")
                try
                    cclose
                    unlet t:cope_open
                    echo "Quickfix closed"
                catch
                    let t:cope_open = 1
                    botright cope
                    echo "Quickfix open"
                endtry
            else
                let t:cope_open = 1
                botright cope
                echo "Quickfix open"
            endif
        endfunction
        map <silent> <F8> :call ToggleCope()<CR>

        function! ArrangeCope()
            botright cwindow 10
            let t:cope_open = 1
        endfunction

        map <silent> <F8> :call ToggleCope()<CR>
        autocmd FileType qf noremap <silent><buffer> q :call ToggleCope()<CR>

        autocmd QuickFixCmdPost * call ArrangeCope()

        nnoremap [1;3B :cn<CR>
        nnoremap [1;3A :cp<CR>

    " To Python
        map <Leader>da gg0idata = """<ESC>GA"""<CR><CR>
        vmap <Leader>ep :!python<CR>
        nmap <Leader>ep :%!python<CR>

        autocmd BufRead *.py set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
        autocmd BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
        autocmd BufRead *.py nmap <F5> :!python %<CR>

" PLUGINS:
" -----------------------------------------------------------------------------
    if has('vim_starting')
       set runtimepath+=~/.vim/bundle/neobundle.vim/
    endif

    call neobundle#rc(expand('~/.vim/bundle/'))

    NeoBundleFetch 'Shougo/neobundle.vim'
    NeoBundle 'jpalardy/vim-slime'
    NeoBundle 'phillipberndt/python-imports.vim'
    NeoBundle 'vim-scripts/python_match.vim'
    NeoBundle 'vim-scripts/matchit.zip'
    NeoBundle 'tpope/vim-surround'
    NeoBundle 'tpope/vim-unimpaired'
    NeoBundle 'tpope/vim-commentary'
    NeoBundle 'tpope/vim-repeat'
    NeoBundle 'https://bitbucket.org/larchange/supernormal'
    NeoBundle 'https://bitbucket.org/larchange/underline.vim'
    NeoBundle 'Shougo/unite-outline'
    NeoBundle 'tacroe/unite-mark'
    NeoBundle 'michaeljsmith/vim-indent-object'
    NeoBundle 'Lokaltog/vim-easymotion'
    NeoBundle 'Valloric/YouCompleteMe', {
        \     'build' : {
        \         'unix' : './install.sh'
        \     }
        \ }

    NeoBundle 'Shougo/vimproc', {
        \     'build' : {
        \         'windows' : 'make -f make_mingw32.mak',
        \         'unix' : 'make -f make_unix.mak',
        \    },
        \ }

    NeoBundle 'http://bitbucket.org/sjl/gundo.vim'
        nnoremap <F6> :GundoToggle<CR>
        inoremap <F6> <ESC>:GundoToggle<CR>

    NeoBundle  'git://repo.or.cz/vcscommand.git'
        nnoremap <Leader>cR <plug>VCSRevert
        let VCSCommandDeleteOnHide=1

    NeoBundle 'nanotech/jellybeans.vim'
        colorscheme jellybeans

    NeoBundle 'bling/vim-airline'
        set laststatus=2
        let g:airline_theme='powerlineish'
        let g:airline_left_sep=''
        let g:airline_right_sep=''
        let g:airline#extensions#tabline#enabled = 1

    NeoBundle 'Shougo/unite.vim'
        let g:unite_source_history_yank_enable = 1
        call unite#filters#matcher_default#use(['matcher_fuzzy'])
        nnoremap <C-p> :<C-u>Unite -no-split -buffer-name=files -start-insert file_rec/async<cr>
        nnoremap <F10> :<C-u>Unite -no-split -buffer-name=files -start-insert file<cr>
        nnoremap <F9> :<C-u>Unite -no-split -buffer-name=mru   -start-insert file_mru<cr>
        nnoremap <F4> :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
        nnoremap <Leader>m :<C-u>Unite -no-split -buffer-name=mark -start-insert mark<cr>
        nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank -start-insert history/yank<cr>
        nnoremap <F12> :<C-u>Unite -no-split -buffer-name=buffer -start-insert buffer<cr>

        " Custom mappings for the unite buffer
        function! s:unite_settings()
            " Enable navigation with control-j and control-k in insert mode
            imap <buffer> <C-j>   <Plug>(unite_select_next_line)
            imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
            nmap <buffer> <backspace> i<backspace>
        endfunction
        autocmd FileType unite call s:unite_settings()

    NeoBundleCheck

" LAST: CONFIGURATIONS
" -----------------------------------------------------------------------------
    " Apply the filetype customization only at the end... to avoid conflict
    filetype plugin on

    " Automatic reloading of .vimrc
    if !exists("autocommandes_incluses")
        let autocommandes_incluses=1
        autocmd bufwritepost $MYVIMRC source $MYVIMRC
    endif
