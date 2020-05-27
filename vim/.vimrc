" Sensible.vim - Defaults
    " Version 1.2
    " Hopefully this should be a good starting point for me!
    let mapleader = "-"
    let maplocalleader = "\\"
    "
    if exists('g:loaded_sensible') || &compatible
	    finish
    else
	    let g:loaded_sensible = 'yes'
    endif
    "
    if has('autocmd')
	    filetype plugin indent on
    endif
    if has('syntax') && !exists('g:syntax_on')
	    syntax enable
    endif
    "
    " Use :help 'option' to see documentation for the given option
    "
    set autoindent
    set backspace=indent,eol,start
    set complete-=i
    set smarttab
    "
    set nrformats-=octal
    "
    if !has('nvim') && &ttimeoutlen == -1
	    set ttimeout
	    set ttimeoutlen=100
    endif
    "
    set incsearch
    " Use <C-L> to clear the highlighting of :set hlsearch
    if maparg('<C-L>', 'n') ==# ''
	    nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
    endif
    "
    set laststatus=2
    set ruler
    set wildmenu
    "
    if !&scrolloff
	    set scrolloff=1
    endif
    if !&sidescrolloff
	    set sidescrolloff=5
    endif
    set display+=lastline
    "
    if &encoding ==# 'latin1' && has('gui_running')
	    set encoding=utf-8
    endif
    "
    if &listchars ==# 'eol:$'
	    set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
    endif
    "
    if v:version > 703 || v:version == 703 && has("patch541")
	    set formatoptions+=j " Delete comment character when joining commented lines
    endif
    "
    if has('path_extra')
	    setglobal tags-=./tags tags-=./tags; tags^=./tags;
    endif
    "
    if &shell =~# 'fish$' && (v:version < 704 || v:version == 704 && !has('patch276'))
	    set shell=/usr/bin/env\ bash
    endif
    "
    set autoread
    "
    if &history < 1000
	    set history=1000
    endif
    if &tabpagemax < 50
	    set tabpagemax=50
    endif
    if !empty(&viminfo)
	    set viminfo^=!
    endif
    set sessionoptions-=options
    set viewoptions-=options
    "
    " Allow color schemes to do bright colors without forcing bold
    if &t_Co == 8 && $TERM !~# '^Eterm'
	    set t_Co=16
    endif
    "
    " Load matchit.vim, but only if the user hasn't installed a newer version
    if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
	    runtime! macros/matchit.vim
    endif

    if empty(mapcheck('<C-U>', 'i'))
	    inoremap <C-U> <C-G>u<C-U>
    endif
    if empty(mapcheck('<C-W>', 'i'))
	    inoremap <C-W> <C-G>u<C-W>
    endif
    "
    " vim:set ft=vim et sw=2

" Vundle Extension Manager
    " Vundle Setup
	set nocompatible 		" required
	filetype off			" required
	
	" set the runtime path to include Vundle and initialize
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()
	
	" alternatively, pass a path where Vundle should install plugins
	" call vundle#begin('~/some/path/here')
	
	" let Vundle manage Vundle, required
	Plugin 'gmarik/Vundle.vim'
	
    " Add Plugins Here
	" Search for Vundle links on https://vimawesome.com
	Plugin 'tmhedberg/SimpylFold'
	Plugin 'vim-scripts/indentpython.vim'
	Plugin 'Valloric/YouCompleteMe'
	Plugin 'vim-syntastic/syntastic'
	Plugin 'morhetz/gruvbox'
	Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
	Plugin 'christoomey/vim-tmux-navigator'
	Plugin 'sheerun/vim-polyglot'
	Plugin 'dense-analysis/ale'
	Plugin 'prettier/vim-prettier', { 'do': 'yarn install' }
	Plugin 'godlygeek/tabular' | Plugin 'plasticboy/vim-markdown'

    " All of your Plugins must be added before the following line
	call vundle#end() 		" required
	filetype plugin indent on	" required
    
    " Brief help
	" :PluginList          - list configured plugins
	" :PluginInstall(!)    - install (update) plugins
	" :PluginSearch(!) foo - search (or refresh cache first) for foo
	" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
	
	" see :h vundle for more details or wiki for FAQ
	" Put your non-Plugin stuff after this line

" Plugin/General Modifications
    " Folding Mods
	set foldenable
	set foldmethod=indent
	set foldlevel=99
	" Auto remember folds
	augroup remember_folds
	    autocmd!
	    autocmd BufWinLeave * mkview
	    autocmd BufWinEnter * silent! loadview
	augroup END
	" Enable folding with the spacebar
	nnoremap <space> za
	set shiftwidth=4
	" View docstrings for folded code
	let g:SimplyFold_docstring_preview=1
    " YouCompleteMe Mods
	let g:ycm_autoclose_preview_window_after_completion=1
	map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
    " Gruvbox Mods
	let g:gruvbox_italic=1
	set termguicolors
	colorscheme gruvbox
	set bg=dark
    " Vimux Mods
	" Prompt for a command to run
	nnoremap <leader>vp :VimuxPromptCommand<cr>
    " Vim-tmux Navigator Mods
	" Write all buffers before navigating from Vim to tmux pane
	let g:tmux_navigator_save_on_switch = 2
    " Connecting fzf from git
	set rtp+=/.fzf
    " Nerdtree automatically starts when no file is specified
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    " ALE Config
	let g:ale_fix_on_save = 1
	let g:ale_python_executable='python3'
	let g:ale_python_pylint_use_global=1
	" Fixers
	    let g:ale_fixers = {
	    \   'javascript': ['eslint'],
	    \   'html':       ['prettier'],
	    \   'css':        ['prettier'],
            \   'markdown':   ['prettier'],
	    \   'python':     ['black'],
	    \}
	" Linters
	    let g:ale_linters = {
	    \	'javascript': ['eslint'],
	    \	'html':	      ['prettier'],
	    \   'css':        ['prettier'],
	    \   'markdown':   ['prettier'],
	    \   'python':     ['pylint'],
	    \}

" Python Modification
    " PEP8 Indentation
	au BufNewFile, BufRead *.py
	\ set tabstop=4
	\ set softtabstop=4
	\ set shiftwidth=4
	\ set textwidth=79
	\ set expandtab
	\ set autoindent
	\ set fileformat=unix
	\ set encoding=utf-8
    " Flag Unnecessary Whitespace
	au BufNewFile, BufRead *.py,*.pyw,*.c,*.h match Cursor /\s\+$/
    " Pretty Python
	let python_highlight_all=1
	syntax on

" Learn Vim the Hard Way
    " DONT print a cute cat whenever opening Vim
    " echo "Welcome to Vim! >^.^<"
    "
    " Map - to cut and paste 1 line below
    noremap <leader>- ddp
    "
    " Map _ to cut and past 1 line ABOVE
    noremap <leader>_ ddkP
    "
    " Map <c-u> to UPPERCASE word in insert mode
    inoremap <leader><c-u> <esc>viwUi
    "
    " Map <c-u> to UPPERCASE word in normal mode
    nnoremap <leader><c-u> viwU
    "
    " allows you to QUICKLY edit the vimrc file from anywhere!
    nnoremap <leader>ev :vsplit $MYVIMRC<cr>
    "
    " allows recent vimrc changes to work in current file!
    nnoremap <leader>sv :source $MYVIMRC<cr>
    "
    " Abbreviations can save lots of typing! This one does my email
    iabbrev @@ christiangonzalezblack@gmail.com
    onoremap in@ :<c-u>execute "normal! /\S*@\w*\.\w*\r:nohlsearch\rviW"<cr>
    "
    " This one does my signature! (name+email)
    iabbrev ssig -- <cr>Christian Gonzalez<cr>christiangonzalezblack@gmail.com
    "
    " Surround word in double quotes (normal mode)
    nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
    "
    " Surround word in single quotes (normal mode)
    nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
    "
    " Surround visually selected word in double quotes
    vnoremap <leader>" <esc>`>a"<esc>`<i"<esc>`<lv`>l
    
        " Easy Comments
    augroup easy_comments
	autocmd!
	autocmd FileType python     nnoremap <buffer> <localleader>c I#<esc>
	autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
	autocmd FileType Vim        nnoremap <buffer> <localleader>c I" <esc>
    augroup END
    
    " javascript abbreviations
    augroup filetype_javascript
	autocmd!
	autocmd FileType javascript :iabbrev <buffer> r; return ;<left>
	autocmd FileType javascript :iabbrev <buffer> return NOPE
	autocmd FileType javascript :iabbrev <buffer> fnc return function () {<enter>}<Up><End><Left><Left><Left>
	autocmd FileType javascript :iabbrev <buffer> function NOPE
    augroup END
    " html abbreviations
    augroup filetype_html
	autocmd!
	autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
    augroup END
    " markdown abbreviations
    augroup filetype_markdown
	autocmd!
	autocmd FileType markdown onoremap <buffer> ih :<c-u>execute "normal! ?^[-=]\\{2,}$\r:nohlsearch\rkvg_"<cr>
	autocmd FileType markdown onoremap <buffer> ah :<c-u>execute "normal! ?^[-=]\\{2,}$\r:nohlsearch\rg_vk0"<cr>
    augroup END

" General Efficiency
    " Cursor Movement
	" Strengthen H to move cursor to beginning of a line
	nnoremap H 0
	nnoremap 0 <nop>
	
	" Strengthen L ti move cursor to end of a line
	nnoremap L $
	nnoremap $ <nop>
	
	" Exit insert mode easily with jk  
	inoremap jk <esc>
    " Split Navigation
	" Easily move between splits with <CTRL> [h,j,k,l]
	nnoremap <C-J> <C-W><C-J>
	nnoremap <C-K> <C-W><C-K>
	nnoremap <C-L> <C-W><C-L>
	nnoremap <C-H> <C-W><C-H>
	" More natural split opening
	set splitbelow
	set splitright
    " Remove annoying highlighting in tmux
	hi clear Comment
	hi clear Folded

" Code-Running Shortcuts
    " Python
	augroup filetype_python
	    autocmd!
	    autocmd FileType python nmap <buffer> <leader>r      :w<CR>:exec '!ipython' shellescape(@%, 1)<CR>
	    autocmd FileType python imap <buffer> <leader>r <esc>:w<CR>:exec '!ipython' shellescape(@%, 1)<CR>
	augroup END
    " Javascript
	augroup filetype_javascript
	    autocmd!
	    autocmd FileType javascript nmap <buffer> <leader>r      :w<CR>:exec '!node' shellescape(@%, 1)<CR>
	    autocmd FileType javascript imap <buffer> <leader>r <esc>:w<CR>:exec '!node' shellescape(@%, 1)<CR>
	augroup END
    " HTML
	 augroup filetype_html
	    autocmd!
	    autocmd FileType html nmap <buffer> <leader>r      :w<CR>:exec '!firefox' shellescape(@%, 1)<CR>
	    autocmd FileType html imap <buffer> <leader>r <esc>:w<CR>:exec '!firefox' shellescape(@%, 1)<CR>	
	augroup END
    " Markdown
	augroup filetype_markdown
	    autocmd!
	    autocmd FileType markdown nmap <buffer> <leader>r      :w<cr>:exec '!grip -b %'<cr>
	    autocmd FileType markdown imap <buffer> <leader>r <esc>:w<cr>:exec '!grip -b %'<cr>
	augroup END
	
