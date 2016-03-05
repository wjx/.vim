My vim environment.
===================

Installation
------------
for i in ~/.vim ~/.vimrc ~/.gvimrc; do [ -e $i ] && mv $i $i.old; done
git clone git://github.com/wjx/.vim.git ~/.vim
ln -s ~/.vim/.vimrc ~/.vimrc
cd ~/.vim
git submodule init
git submodule update

Update a plugin bundle
----------------------
cd ~/.vim/bundle/fugitive
git pull origin master

Upgrading all bundled plugins
-----------------------------
git submodule foreach git pull origin master

Install plugins as submodules
-----------------------------
git submodule add http://github.com/tpope/vim-fugitive.git bundle/fugitive
git commit -m "Install Fugitive.vim bundle as a submodule."
