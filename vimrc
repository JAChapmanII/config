set nocompatible

" Appearance options
filetype on
filetype plugin on
filetype indent on
syntax on

set number
set ruler
set backspace=indent,eol,start
set scrolloff=3

" Backup options
set backup
set backupdir=~/.config/vim/backup
set directory=~/.config/vim/tmp

" Tabbing options
set tabstop=3
set shiftwidth=3
set autoindent
set smartindent

" Search options
set ignorecase
set smartcase
set showmatch
set incsearch
set hlsearch

" Allow hiding of buffers with unwritten data
set hidden

" Folding options
set foldmethod=marker
nnoremap <space> za

" Search Options
" center match on screen
map N Nzz
map n nzz

" Swap ; and : when in command mode
nnoremap ; :
nnoremap : ;

" Change the way invisible characters are viewed
if &term !=# "linux"
	set list listchars=tab:»\ ,trail:·
endif

" Strip extra ending space on write
"autocmd BufWritePre * :%s/\s\+$//e

highlight OverLength ctermbg=lightgrey ctermfg=darkgrey
match OverLength /\%81v.*/

set textwidth=78
set formatoptions=c,q,r,t

" Make <F2> be a paste toggle to fix pasting with ai
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" Colorscheme
"colorscheme anotherdark

set background=light

