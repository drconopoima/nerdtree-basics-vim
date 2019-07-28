set showcmd " Show (partial) command in status line.
set showmatch " Show matching brackets.
set incsearch " Incremental search
set autowrite " Automatically save before commands like :next and :make
set hidden " Hide buffers when they are abandoned
set mouse=a " Enable mouse usage (all modes)
set nocompatible              " be iMproved, required
filetype off                  " required
execute pathogen#infect()
" Turn on syntax highlighting.
syntax on
filetype plugin indent on
" Automatically wrap text that extends beyond the screen length.
set wrap
" Vim's auto indentation feature does not work properly with text copied from outisde of Vim. Press the <F2> key to toggle paste mode on/off.
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F2>
" Uncomment below to set the max textwidth. Use a value corresponding to the width of your screen.
set textwidth=79
set number
set ignorecase
set smartcase " ...except when serach query contains a capital letter
set autoread        " Auto load files if they change on disc
" Display 5 lines above/below the cursor when scrolling with a mouse.
set scrolloff=7
" Fixes common backspace problems
set backspace=indent,eol,start
" Speed up scrolling in Vim
set ttyfast
" Status bar
set laststatus=2
" Display options
set showmode
" Highlight matching pairs of brackets. Use the '%' character to jump between them.
set matchpairs+=<:>
" Display different types of white spaces.
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
" Set status line display
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%c')}
" Encoding
set encoding=utf-8
" Highlight matching search patterns
set hlsearch
set showcmd
" Store info from no more than 100 files at a time, 9999 lines of text, 100kb of data. Useful for copying large amounts of data between files.
set viminfo='100,<9999,s100
" Map the <Space> key to toggle a selected fold opened/closed.
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
" Automatically save and load folds
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview"
" :W sudo saves the file 
" (useful for handling the permission-denied error)
" For when you forget to sudo.. Really Write the file.
    " General Commands: User Ex commands. {{{1
    cmap W! call WriteAsSuperUser(@%)         " Write file as super-user.
    cmap w!! call WriteAsSuperUser(@%)         " Write file as super-user.

    " Helper Function: Used by user Ex commands. {{{1
        " Due credits to answer by Zenexer at stack overflow https://stackoverflow.com/questions/1005/getting-root-permissions-on-a-file-inside-of-vi/ |12870763#12870763
        function GetNullDevice() " Gets the path to the null device. {{{2
            if filewritable('/dev/null')
                return '/dev/null'
            else
                return 'NUL'
            endif
        endfunction

        function WriteAsSuperUser(file) " Write buffer to a:file as the super user (on POSIX, root). {{{2
            exec '%write !sudo tee ' . shellescape(a:file, 1) . ' >' . GetNullDevice()
        endfunction


    " }}}1
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
set runtimepath^=~/.vim/bundle/ctrlp.vim
function! FindConfig(prefix, what, where)
    let cfg = findfile(a:what, escape(a:where, ' ') . ';')
    return cfg !=# '' ? ' ' . a:prefix . ' ' . shellescape(cfg) : ''
endfunction

autocmd FileType javascript let b:syntastic_javascript_jscs_args =
    \ get(g:, 'syntastic_javascript_jscs_args', '') .
    \ FindConfig('-c', '.jscsrc', expand('<afile>:p:h', 1))
