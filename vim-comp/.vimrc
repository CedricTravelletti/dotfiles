set nocompatible
filetype off
set laststatus=2

execute pathogen#infect()

let g:airline_powerline_fonts=1

"call pathogen#helptags()
"call pathogen#runtime_append_all_bundles()

set foldmethod=syntax
"set foldlevel=3
"set foldnestmax=2

"Set line numbers.
set nu
 
inoremap jk <ESC>
let mapleader = "\<Space>"
filetype plugin indent on
set encoding=utf-8

syntax enable

set tabstop=4
set shiftwidth=4
set expandtab
syntax on
filetype plugin indent on
syntax enable
au FileType py set autoindent
au FileType py set smartindent
au FileType py set textwidth=79


"" Python specific indents.
" au BufNewFile,BufRead *.py set tabstop=4|set softtabstop=4|set shiftwidth=4|set textwidth=79|set expandtab|set autoindent|set fileformat=unix

" au BufNewFile,BufRead *.js, *.html, *.css set tabstop=2|set softtabstop=2|set shiftwidth=2

" Folding

set breakindent
set copyindent
set showmatch
set ignorecase
set smartcase
set smarttab

set hlsearch " highlight search resutls
set incsearch " search as you type
set backspace=indent,eol,start
set title " change terminal title
set undolevels=1000 " more undo history

filetyp plugin indent on
autocmd filetype python set expandtab


set t_Co=256
set background=dark
" let g:solarized_termcolors=256
" let g:solarized_contrast="normal"
colorscheme gruvbox

" Syntastic settings
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
let g:syntastic_loc_list_height = 5

let g:syntastic_python_checkers = ['pyflakes']


" Ignore fascist PEP8 directives.
let g:syntastic_python_flake8_args = '--ignore=W191,W503,E402,E501,E121,E122,E123,E128,E226,E231,E225,E201,E265,E202,W291,W293,E712,E262'

let g:airline_theme="molokai"

setlocal indentexpr=GetGooglePythonIndent(v:lnum)

let s:maxoff = 50 " maximum number of lines to look backwards.

function GetGooglePythonIndent(lnum)

  " Indent inside parens.
  " Align with the open paren unless it is at the end of the line.
  " E.g.
  "   open_paren_not_at_EOL(100,
  "                         (200,
  "                          300),
  "                         400)
  "   open_paren_at_EOL(
  "       100, 200, 300, 400)
  call cursor(a:lnum, 1)
  let [par_line, par_col] = searchpairpos('(\|{\|\[', '', ')\|}\|\]', 'bW',
        \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
        \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
        \ . " =~ '\\(Comment\\|String\\)$'")
  if par_line > 0
    call cursor(par_line, 1)
    if par_col != col("$") - 1
      return par_col
    endif
  endif

  " Delegate the rest to the original function.
  return GetPythonIndent(a:lnum)

endfunction

let pyindent_nested_paren="&sw*2"
let pyindent_open_paren="&sw*2"

" Disable auto-folding in Markdown.
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_toc_autofit = 1

set textwidth=79

" Close autocomplection docs after completion.
let g:ycm_autoclose_preview_window_after_completion=1
let g_ycm_autoclose_preview_window_after_insertion = 1

" Tagbar
nmap <F8> :TagbarToggle<CR>

if exists('$TMUX')
  set term=screen-256color
endif

if exists('$ITERM_PROFILE')
  if exists('$TMUX') 
    let &t_SI = "\<Esc>[3 q"
    let &t_EI = "\<Esc>[0 q"
  else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif
end

