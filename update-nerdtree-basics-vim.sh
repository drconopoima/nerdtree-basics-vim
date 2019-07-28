#!/bin/sh

(cd ~/.vim_nerdtree_basics/ && git fetch -q --depth=1 && git reset -q \
	--hard origin/master && git clean -q -dfx) & (cd \
	~/.vim_nerdtree_basics/vim/autoload/vim-pathogen && git fetch -q \
	--depth=1 && git reset -q --hard origin/master && git clean -q -dfx) \
	& (cd ~/.vim_nerdtree_basics/vim/bundle/ctrlp.vim && git fetch \
	-q --depth=1 && git reset -q --hard origin/master && git clean -q -dfx) & \
	(cd ~/.vim_nerdtree_basics/vim/bundle/nerdtree && git fetch -q \
	--depth=1 && git reset -q --hard origin/master && git clean -q -dfx) & \
	(cd ~/.vim_nerdtree_basics/vim/bundle/nerdtree-git-plugin/ && git \
	fetch -q --depth=1 && git reset -q --hard origin/master && git clean -q \
	-dfx) & (cd ~/.vim_nerdtree_basics/vim/bundle/syntastic/ && git \
	fetch -q --depth=1 && git reset -q --hard origin/master && git \
	clean -q -dfx) & (cd ~/.vim_nerdtree_basics/vim/bundle/vim-polyglot/ \
	&& git fetch -q --depth=1 && git reset -q --hard origin/master && git \
	clean -q -dfx) & wait
