" Load plugins
if filereadable(expand("$XDG_CONFIG_HOME/vim/plugins.vim"))
    source $XDG_CONFIG_HOME/vim/plugins.vim
endif

" General Settings
set encoding=UTF-8              " Set default encoding to UTF-8
set backspace=indent,eol,start  " Allow backspacing over everything in insert mode
set hidden                      " Allow buffer switching without saving
set history=1000                " Store lots of :cmdline history
set showcmd                     " Show incomplete cmds down the bottom
set showmode                    " Show current mode down the bottom
set autoread                    " Reload files changed outside vim
set laststatus=2                " Always display the status line

" UI Settings
set number                      " Show line numbers
set ruler                       " Show ruler
set wrap                        " Wrap lines
set linebreak                   " Wrap lines at convenient points
set list                        " Show invisible characters
set listchars=tab:>·,trail:·    " But only show tabs and trailing whitespace
set scrolloff=3                 " Start scrolling three lines before horizontal border of window
set sidescrolloff=3             " Start scrolling three columns before vertical border of window
set wildmenu                    " Enable command-line completion enhanced mode
set wildmode=list:longest       " Complete only until point of ambiguity

" Indentation and Tabs
set autoindent                  " Auto-indent new lines
set smartindent                 " Enable smart-indent
set smarttab                    " Enable smart-tabs
set shiftwidth=4                " Number of auto-indent spaces
set softtabstop=4               " Number of spaces per Tab
set tabstop=4                   " Number of visual spaces per Tab
set expandtab                   " Use spaces instead of tabs

" Search Settings
set incsearch                   " Find the next match as we type the search
set hlsearch                    " Highlight searches by default
set ignorecase                  " Ignore case when searching...
set smartcase                   " ...unless we type a capital

" Performance Settings
set lazyredraw                  " Don't redraw while executing macros

" Syntax and Colorscheme
syntax on                       " Enable syntax highlighting
set t_Co=256                    " Use 256 colors
set background=dark             " Use dark background
colorscheme desert              " Set color scheme (change as needed)

" File Type Settings
filetype plugin indent on       " Enable filetype detection, plugin, and indent

" Undo Settings
set undofile                    " Maintain undo history between sessions
set undodir=$XDG_CONFIG_HOME/vim/undodir  " Set undo directory
if !isdirectory(&undodir)
    call mkdir(&undodir, 'p', 0700)  " Create undo directory if it doesn't exist
endif

" Plugin-specific Settings
let g:airline_powerline_fonts = 1
let g:gitgutter_terminal_reports_focus=0
let NERDTreeShowHidden=1

" Set Airline theme
let g:airline_theme='ayu'
let ayucolor="dark"
colorscheme ayu

" Key Mappings
let mapleader = ","

" NERDTree mappings
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Other useful mappings
nnoremap <leader>w :w<CR>       " Quick save
nnoremap <leader>q :q<CR>       " Quick quit
nnoremap <leader>x :x<CR>       " Quick save and quit
nnoremap <space> za             " Toggle fold with space

" Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Update time for faster git gutter updates
set updatetime=100

" Enable mouse support
set mouse=a

" Enable clipboard support (if available)
if has('clipboard')
    set clipboard=unnamed       " Use system clipboard
    if has('unnamedplus')       " X11 support
        set clipboard+=unnamedplus
    endif
endif

" Disable audible bell
set noerrorbells visualbell t_vb=

" Disable swap files
set noswapfile
