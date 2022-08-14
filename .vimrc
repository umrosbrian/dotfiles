set nocompatible " Tell Vim to behave like Vim.  Without this Vim will behave like Vi.  This can be shortened to `set nocp`.
filetype off                  " required
syntax enable " show pretty colors
filetype plugin on " enable plugins such as netrw
set path=~,~/python/mypkg,~/python/scripts,~/webserver,~/webserver/static**,~/webserver/templates**,~/flask_fridays " make netrw recursively search for files in Vim's current working directory
set wildmenu " display a banner containing netrw's search results
set visualbell " make the error warning a screen flash rather than a bell sound
set t_vb= " disable the code that would produce a screen flash
set laststatus=2 " turn the status line on if not already and keep it on
set statusline=%F " show the absolute path (%F for absolute, %f for relative) on status line
set statusline+=%= " hmm, don't know what this is doing...putting file path on the left side and working directory on right?
set statusline+=%{getcwd()} " show Vim's CWD
set nu " turn on line numbers
" set hidden " avoid the 'E37: No write since last change (add ! to override)' error when you open a new file without saving the current buffer first

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
" Plugin 'nathanaelkane/vim-indent-guides'
" Plugin 'iamcco/markdown-preview.nvim'
" python-mode's recommended installation is done via pathogen, however, Vundle
" can handle pathogen plugins by using 'Bundle' rather than 'Plugin' along
" with the 'python-mode/python-mode' GitHub alias
" Bundle 'python-mode/python-mode'
" Plugin 'jiangmiao/auto-pairs' " https://github.com/jiangmiao/auto-pairs
" Plugin 'davidhalter/jedi-vim' " https://github.com/davidhalter/jedi-vim - trying this since it's used for .py files in YouCompleteMe...too lightweight after you've used YCM
" Plugin 'jupyter-vim/jupyter-vim' " https://github.com/jupyter-vim/jupyter-vim - send selection of python code to jupyter

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

":color desert
:set number
" set the line numbers to blue so they can bee seen in an inactive tmux pane
:highlight LineNr ctermfg=blue

" I need this on for the Darter Pro...I've got it off for all other machines
:syntax on

" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

""------------------------------------------------------------------
"" make PEP 8 (python standard) indentation when a .py file is opened
"" the silent! makes vim open without having a prompt
"au BufNewFile,BufRead silent! *.py
"set tabstop=4 " use 4 spaces to represent tab
"set softtabstop=4 " like setting an intentation tab...even if a character has been placed at the start of a line a tab would still end up at 4 chars from the start of the line rather than 3
"set shiftwidth=4 " number of spaces to use for auto indent
""set textwidth=79 " break lines when line length reaches x characters
"set expandtab " enter spaces when tab is pressed
"set autoindent " copy indent from current line when starting a new line
"set fileformat=unix " I think this removes \r
"
"" set the indentation for .sh files
"" the silent! makes vim open without having a prompt
""au BufNewFile,BufRead silent! *.sh
""set tabstop=2
""set softtabstop=2
""set shiftwidth=2

" map the leader to space bar
let mapleader = " "
" insert 'checkVar '
nnoremap <leader>cv icheckVar<Space>

" set encryption method to blowfish2
set cm=blowfish2
" don't write backups as they would leave behind a trace of any encrypted file's contents
set viminfo=
set nobackup
set nowritebackup

" attempt to set tslime keybindings
"let g:tslime_always_current_session = 1
"let g:tslime_always_current_window = 1
"nmap <leader>r <Plug>NormalModeSendToTmux
"nmap <C-c>r <Plug>SetTmuxVars
"vmap <leader>r <Plug>SendSelectionToTmux

" set the indentation colors for the 'vim-indent-guides' plugin
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

" paste from the clipboard with 'Ctrl+v' in both normal and insert mode
nmap <C-V> "+gP
imap <C-V> <ESC><C-V>i
" copy to clipboard with 'Ctrl+c' in visual mode
vmap <C-C> "+y

" switch windows using vim navigation keys...e.g. 'Ctrl+j' would switch focus
" down
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"comment sql line
nnoremap <leader>cls ^i--<Esc>
"comment python line
nnoremap <leader>clp ^i#<Esc>
" comment html line
nnoremap <leader>clh ^i<!--<Esc>$a--><Esc>
"uncomment sql line
nnoremap <leader>uls :s/^\([[:space:]]*\)\(--\)/\1<CR>
"uncomment python line
nnoremap <leader>ulp :s/^\([[:space:]]*\)\(#\)/\1<CR>
" uncomment html line
nnoremap <leader>ulh :s/^\([[:space:]]*\)\(<!--\)/\1<CR>:s/-->$//<CR>

"comment sql block...move cursor to first line, type 'mt' to set a mark, type the last line number, execute the shortcut...
"it jumps to the last line then does a substitution with the range being from the mark to the current line
nnoremap <leader>cbs G:'t,.s/^/--/<CR>
"comment python block...move cursor to first line, type 'mt' to set a mark, type the last line number, execute the shortcut...
"it jumps to the last line then does a substitution with the range being from the mark to the current line
nnoremap <leader>cbp G:'t,.s/^/#/<CR>

"uncomment sql block...same as the comment block shortcut but the 't at the end moves the cursor back to the mark
nnoremap <leader>ucbs G:'t,.s/^--//<CR>'t
"uncomment python block...same as the comment block shortcut but the 't at the end moves the cursor back to the mark
nnoremap <leader>ucbp G:'t,.s/^#//<CR>'t
"indent python block...works for mardown too
nnoremap <leader>ib G:'t,.s/^/    /<CR>'t
"unindent python block...works for mardown too
nnoremap <leader>uib G:'t,.s/^    //<CR>'t

"join lines without adding a space
nnoremap <leader>jl $Jx

""print 'sql_composed = sql.SQL("").format()' by typing 'SC'
""this will go into insert mode after the first double quote
"inoremap SC sql_composed = sql.SQL("").format()<Esc>2F"a
"
""print 'pgdb.curs.execute(sql_composed)' by typing 'EC'
""this will go into insert mode after 'sql_composed' in order to provide a
""list/tuple for any '%s' placeholder
"inoremap EC pgdb.curs.execute(sql_composed)<Esc>ha
"
""print 'pgdb.attempt_commit()' by typing 'AC'
"inoremap AC pgdb.attempt_commit()
"
""print 'pgdb.fetchone()' by typing 'FO'
"inoremap FO pgdb.curs.fetchone()
"
""print 'pgdb.fetchall()' by typing 'FA'
"inoremap FA pgdb.curs.fetchall()

"jump out to the right side of closed parenthesis or single quotes
inoremap JO <Right>

"print a horizontal line by typing 'HL'
inoremap HL -----------------------------------------------------------------------------------------------------------------------------------------------------------------------<Esc>o

" print <td></td> then jump between the tags
inoremap TD <td></td><Esc>4hi

" print LaTeX fractions - this populates the numerator then moves cursor to
" the denominator
inoremap Fone $\frac{1}{}$<Esc>hi
inoremap Ftwo $\frac{2}{}$<Esc>hi
inoremap Fthree $\frac{3}{}$<Esc>hi

" print a LaTeX circle, which is similar to a degree symbol
inoremap DEG  $^{\circ}$ 

" hit 'leader + p' when in normal (not visual or insert) mode to toggle paste mode on/off
function! TogglePaste()
    if(&paste == 0)
        set paste
        echo "Paste Mode Enabled"
    else
        set nopaste
        echo "Paste Mode Disabled"
    endif
endfunction
map <leader>p :call TogglePaste()<cr>

" settings for python-mode plugin
let g:pymode_options_colorcolumn = 0

" run python code by hitting F9 - this will put you in a python terminal where
" if you've used a breakpoint() in the code you'll be able to evaluate
" variable that are in the code
" https://stackoverflow.com/questions/18948491/running-python-code-in-vim
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

" issue :Pub to convert the opened .md file to .html
command! Pub !md_to_php.py %
" remove all backslash escapes in a .md file
command! RemoveEscapes !remove_all_escapes_in_md.py %

" Rename tabs to show tab number.
" (Based on http://stackoverflow.com/questions/5927952/whats-implementation-of-vims-default-tabline-function)
if exists("+showtabline")
    function! MyTabLine()
        let s = ''
        let wn = ''
        let t = tabpagenr()
        let i = 1
        while i <= tabpagenr('$')
            let buflist = tabpagebuflist(i)
            let winnr = tabpagewinnr(i)
            let s .= '%' . i . 'T'
            let s .= (i == t ? '%1*' : '%2*')
            let s .= ' '
            let wn = tabpagewinnr(i,'$')

            let s .= '%#TabNum#'
            let s .= i
            " let s .= '%*'
            let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
            let bufnr = buflist[winnr - 1]
            let file = bufname(bufnr)
            let buftype = getbufvar(bufnr, 'buftype')
            if buftype == 'nofile'
                if file =~ '\/.'
                    let file = substitute(file, '.*\/\ze.', '', '')
                endif
            else
                let file = fnamemodify(file, ':p:t')
            endif
            if file == ''
                let file = '[No Name]'
            endif
            let s .= ' ' . file . ' '
            let i = i + 1
        endwhile
        let s .= '%T%#TabLineFill#%='
        let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
        return s
    endfunction
    set stal=2
    set tabline=%!MyTabLine()
    set showtabline=1
    highlight link TabNum Special
endif
