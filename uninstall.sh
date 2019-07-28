#!/usr/bin/env sh

# Credits to spf13's for this uninstall script which is an updated version from
# the one in project spf13-vim at https://github.com/spf13/spf13-vim

app_dir="$HOME/.vim"

warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

rm $HOME/.vimrc
rm -rf $HOME/.vim/bundle
rm -rf $HOME/.vim/autoload

rm -rf $app_dir
