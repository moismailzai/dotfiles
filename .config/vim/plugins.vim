" Vundle Configuration
set nocompatible              " be iMproved, required
filetype off                  " required

" Set the runtime path to include Vundle and initialize
set rtp+=$XDG_CONFIG_HOME/vim/bundle/Vundle.vim
call vundle#begin('$XDG_CONFIG_HOME/vim/bundle')

" Let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Your plugins...
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'preservim/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'ryanoasis/vim-devicons'
Plugin 'sheerun/vim-polyglot'
Plugin 'tpope/vim-eunuch'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required