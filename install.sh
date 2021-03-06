#!/bin/sh

# Credits to the project SpaceVim at https://spacevim.org/i
# This install script has been heavily based on their version
# Mine differs only in updating in order to shallow clone repos
# and updating in-place shallow cloned repos.

# Init option {{{
Color_off='\033[0m'       # Text Reset

# terminal color template {{{
# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White

# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White

# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\033[0;100m'   # Black
On_IRed='\033[0;101m'     # Red
On_IGreen='\033[0;102m'   # Green
On_IYellow='\033[0;103m'  # Yellow
On_IBlue='\033[0;104m'    # Blue
On_IPurple='\033[0;105m'  # Purple
On_ICyan='\033[0;106m'    # Cyan
On_IWhite='\033[0;107m'   # White
# }}}

# version
Version='0.9.0'

# }}}

# success/info/error/warn {{{
msg() {
  printf '%b\n' "$1" >&2
}

success() {
  msg "${Green}[✔]${Color_off} ${1}${2}"
}

info() {
  msg "${Blue}[➭]${Color_off} ${1}${2}"
}

error() {
  msg "${Red}[✘]${Color_off} ${1}${2}"
  exit 1
}

warn () {
  msg "${Yellow}[⚠]${Color_off} ${1}${2}"
}
# }}}

# echo_with_color {{{
echo_with_color () {
  printf '%b\n' "$1$2$Color_off" >&2
}
# }}}

# fetch_repo {{{
fetch_repo () {
  if [[ -d "$HOME/.vim_nerdtree_basics" ]]; then
    info "Trying to update Nerdtree-basics-vim"
    cd "$HOME/.vim_nerdtree_basics"
    (cd ~/.vim_nerdtree_basics/ && git fetch -q --depth=1 && git reset -q \
	--hard origin/master && git clean -q -dfx) & (cd \
	~/.vim_nerdtree_basics/vim/autoload/vim-pathogen && git fetch -q \
	--depth=1 && git reset -q --hard origin/master && git clean -q -dfx) \
	& (cd ~/.vim_nerdtree_basics/vim/bundle/ctrlp.vim && git fetch -q \
	--depth=1 && git reset -q --hard origin/master && git clean -q -dfx) & \
	(cd ~/.vim_nerdtree_basics/vim/bundle/nerdtree && git fetch -q \
	--depth=1 && git reset -q --hard origin/master && git clean -q -dfx) & \
	(cd ~/.vim_nerdtree_basics/vim/bundle/nerdtree-git-plugin/ && git \
	fetch -q --depth=1 && git reset -q --hard origin/master && git clean -q \
	-dfx) & (cd ~/.vim_nerdtree_basics/vim/bundle/syntastic/ && git \
	fetch -q --depth=1 && git reset -q --hard origin/master && git \
	clean -q -dfx) & (cd ~/.vim_nerdtree_basics/vim/bundle/vim-polyglot/ \
	&& git fetch -q --depth=1 && git reset -q --hard origin/master && git \
	clean -q -dfx) & wait
    if ! [[ "$(readlink $HOME/.vim/bundle/ctrlp.vim)" =~ \
	    \.vim_nerdtree_basics/vim/bundle/ctrlp.vim$ ]]; then
        ln -s "$HOME/.vim_nerdtree_basics/vim/bundle/ctrlp.vim" "$HOME/.vim/bundle"
    fi
    if ! [[ "$(readlink $HOME/.vim/autoload/pathogen.vim)" =~ \
	    \.vim_nerdtree_basics/vim/autoload/vim-pathogen/autoload/pathogen.vim$ ]]; then
	ln -s \
	"$HOME/.vim_nerdtree_basics/vim/autoload/vim-pathogen/autoload/pathogen.vim" "$HOME/.vim/autoload/"
    fi
    if ! [[ "$(readlink $HOME/.vim/bundle/nerdtree)" =~ \
	    \.vim_nerdtree_basics/vim/bundle/nerdtree$ ]]; then
        ln -s "$HOME/.vim_nerdtree_basics/vim/bundle/nerdtree" "$HOME/.vim/bundle"
    fi
    if ! [[ "$(readlink $HOME/.vim/bundle/nerdtree-git-plugin)" =~ \
	    \.vim_nerdtree_basics/vim/bundle/nerdtree-git-plugin$ ]]; then
        ln -s "$HOME/.vim_nerdtree_basics/vim/bundle/nerdtree-git-plugin" "$HOME/.vim/bundle"
    fi
    if ! [[ "$(readlink $HOME/.vim/bundle/syntastic)" =~ \
	    \.vim_nerdtree_basics/vim/bundle/syntastic$ ]]; then
        ln -s "$HOME/.vim_nerdtree_basics/vim/bundle/syntastic" "$HOME/.vim/bundle"
    fi
    if ! [[ "$(readlink $HOME/.vim/bundle/vim-polyglot)" =~ \
	    \.vim_nerdtree_basics/vim/bundle/vim-polyglot$ ]]; then
        ln -s "$HOME/.vim_nerdtree_basics/vim/bundle/vim-polyglot" "$HOME/.vim/bundle"
    fi
    if ! [[ -f "$HOME/.vimrc" ]]; then
        ln -s "$HOME/.vim_nerdtree_basics/vimrc" "$HOME/.vimrc"
    fi
    success "Successfully updated Nerdtree-basics-vim"
  else
    info "Trying to clone Nerdtree-basics-vim"
    git clone -q --recursive --depth=1 -b master https://github.com/drconopoima/nerdtree-basics-vim.git "$HOME/.vim_nerdtree_basics"
    success "Successfully cloned Nerdtree-basics-vim"
  fi
}
# }}}

# install_vim {{{
install_vim () {
  
  if [[ -d "$HOME/.vim" ]]; then
    if [ -d "$HOME/.vim_nerdtree_basics/" ]; then
      success "Nerdtree-basics-vim appears to be already installed and has been
      updated."
    else
      mv "$HOME/.vim" "$HOME/.vim_backup"
      success "BackUp $HOME/.vim to $HOME/.vim_backup"
      rm -rf "$HOME/.vim"
      mkdir -p "$HOME/.vim/autoload/"
      mkdir "$HOME/.vim/bundle"
      ln -s "$HOME/.vim_nerdtree_basics/vim/autoload/vim-pathogen/autoload/pathogen.vim" "$HOME/.vim/autoload/"
      ln -s "$HOME/.vim_nerdtree_basics/vim/bundle/ctrlp.vim" "$HOME/.vim/bundle"
      ln -s "$HOME/.vim_nerdtree_basics/vim/bundle/nerdtree" "$HOME/.vim/bundle"
      ln -s "$HOME/.vim_nerdtree_basics/vim/bundle/nerdtree-git-plugin" "$HOME/.vim/bundle"
      ln -s "$HOME/.vim_nerdtree_basics/vim/bundle/syntastic" "$HOME/.vim/bundle"
      ln -s "$HOME/.vim_nerdtree_basics/vim/bundle/vim-polyglot" "$HOME/.vim/bundle"
      if [[ -f "$HOME/.vimrc" ]]; then
        mv "$HOME/.vimrc" "$HOME/.vimrc_backup"
        success "Backup $HOME/.vimrc to $HOME/.vimrc_backup"
      fi 
      ln -s "$HOME/.vim_nerdtree_basics/vimrc" "$HOME/.vimrc"
      success "Installed Nerdtree-basics-vim"
    fi
  else
    mkdir -p ~/.vim/autoload/
    mkdir "$HOME/.vim/bundle"
    ln -s "$HOME/.vim_nerdtree_basics/vim/autoload/vim-pathogen/autoload/pathogen.vim" "$HOME/.vim/autoload/"
    ln -s "$HOME/.vim_nerdtree_basics/vim/bundle/ctrlp.vim" "$HOME/.vim/bundle"
    ln -s "$HOME/.vim_nerdtree_basics/vim/bundle/nerdtree" "$HOME/.vim/bundle"
    ln -s "$HOME/.vim_nerdtree_basics/vim/bundle/nerdtree-git-plugin" "$HOME/.vim/bundle"
    ln -s "$HOME/.vim_nerdtree_basics/vim/bundle/syntastic" "$HOME/.vim/bundle"
    ln -s "$HOME/.vim_nerdtree_basics/vim/bundle/vim-polyglot" "$HOME/.vim/bundle"
    ln -s "$HOME/.vim_nerdtree_basics/vimrc" "$HOME/.vimrc"
    success "Installed Nerdtree-basics-vim"
  fi
}
# }}}



### main {{{
main () {
  if [ $# -gt 0 ]
  then
    case $1 in
      --install|-i)
        fetch_repo
        if [ $# -eq 2 ]
        then
              install_vim
              exit 0
        fi
        install_vim
        exit 0
        ;;
      --version|-v)
        msg "${Version}"
        exit 0
    esac
  else
    fetch_repo
    install_vim
  fi
}

# }}}

main $@
