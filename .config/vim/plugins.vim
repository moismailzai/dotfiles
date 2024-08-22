" Vundle Configuration
set nocompatible              " be iMproved, required
filetype off                  " required

" Check if Vundle is installed
let vundle_readme=expand('$XDG_CONFIG_HOME/vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
  echo "Installing Vundle.."
  echo ""
  silent !mkdir -p $XDG_CONFIG_HOME/vim/bundle
  silent !git clone https://github.com/VundleVim/Vundle.vim.git $XDG_CONFIG_HOME/vim/bundle/Vundle.vim
  let vundle_installed=1
endif

" Set the runtime path to include Vundle and initialize
set rtp+=$XDG_CONFIG_HOME/vim/bundle/Vundle.vim
try
  call vundle#begin('$XDG_CONFIG_HOME/vim/bundle')

  " Let Vundle manage Vundle, required
  Plugin 'VundleVim/Vundle.vim'

  " Your plugins...
  Plugin 'airblade/vim-gitgutter'
  Plugin 'vim-airline/vim-airline'
  Plugin 'vim-airline/vim-airline-themes'
  Plugin 'ayu-theme/ayu-vim'
  Plugin 'preservim/nerdtree'
  Plugin 'Xuyuanp/nerdtree-git-plugin'
  Plugin 'ryanoasis/vim-devicons'
  Plugin 'sheerun/vim-polyglot'
  Plugin 'tpope/vim-eunuch'

  " All of your Plugins must be added before the following line
  call vundle#end()            " required
catch
  echo "Vundle is not installed. Please run :PluginInstall after Vim starts."
endtry

filetype plugin indent on    " required

" If Vundle was just installed, install plugins
if exists("vundle_installed") && vundle_installed == 1
  echo "Installing Plugins, please ignore key map error messages"
  echo ""
  :PluginInstall
endif
