set nocompatible
set encoding=utf-8

" Appearance options
set t_Co=256
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

" Highlight long lines
match ErrorMsg '\%>80v.\+'

set textwidth=78
set formatoptions=c,q,r,t

" Make <F2> be a paste toggle to fix pasting with ai
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" Colorscheme
"colorscheme anotherdark
set background=light
"set background=dark

" Transparent editing of gpg encrypted files
" copied from: http://vim.wikia.com/wiki/Encryption
augroup encrypted
	au!
	" First make sure nothing is written to ~/.viminfo while editing an
	" encrypted file.
	autocmd BufReadPre,FileReadPre *.gpg set viminfo=
	" We don't want a swap file, as it writes unencrypted data to disk
	autocmd BufReadPre,FileReadPre *.gpg set noswapfile

	" Switch to binary mode to read the encrypted file
	autocmd BufReadPre,FileReadPre *.gpg set bin
	autocmd BufReadPre,FileReadPre *.gpg let ch_save = &ch|set ch=2
	" (If you use tcsh, you may need to alter this line.)
	autocmd BufReadPost,FileReadPost *.gpg '[,']!gpg --decrypt 2> /dev/null

	" Switch to normal mode for editing
	autocmd BufReadPost,FileReadPost *.gpg set nobin
	autocmd BufReadPost,FileReadPost *.gpg let &ch = ch_save|unlet ch_save
	autocmd BufReadPost,FileReadPost *.gpg execute ":doautocmd BufReadPost " . expand("%:r")

	" Convert all text to encrypted text before writing
	autocmd BufWritePre,FileWritePre *.gpg '[,']!gpg --default-recipient-self -ae 2>/dev/null
	" Undo the encryption so we are back in the normal text, directly after
	" the file has been written.
	autocmd BufWritePost,FileWritePost *.gpg u
augroup END

