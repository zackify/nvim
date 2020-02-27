" Basic Setup "
"
"
"

	" Set default to 2 space indent "
	set expandtab
	set tabstop=2
	set softtabstop=2
	set shiftwidth=2
	set number
	set ignorecase

        
	" netrw settings "
	let g:netrw_banner = 0
	let g:netrw_winsize = 25

	" save on every escape "
        inoremap <Esc> <Esc>:w<CR>

	" set leader to space "
	:let mapleader = " "


" Plugins "
"
"
"

	call plug#begin('~/.vim/plugged')
	Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install() }}
	Plug 'sheerun/vim-polyglot'
	Plug 'rust-lang/rust.vim'
	Plug 'vim-syntastic/syntastic'
	Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
	Plug 'scrooloose/nerdtree'
	Plug 'ryanoasis/vim-devicons'
        Plug 'vim-airline/vim-airline-themes'
	Plug 'vim-airline/vim-airline'
	Plug 'mhinz/vim-startify'
        Plug 'haya14busa/incsearch.vim'
	Plug 'preservim/nerdcommenter'

	call plug#end()
	let g:rustfmt_autosave = 1

	execute pathogen#infect()


" Plugin Setup "
"
"
"
        " === startup === "
	
	" Startify then NERDTree, on startup
	autocmd VimEnter *
			\   if !argc()
			\ |   Startify
			\ |   NERDTree
			\ |   wincmd w
			\ | endif


	" air-line
	let g:airline_powerline_fonts = 1
	let g:airline_extensions = ['branch', 'hunks', 'coc', 'tabline']
	let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
	let g:airline#extensions#tabline#buffer_nr_show = 1
	let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'z', 'warning', 'error']]
	let g:airline_skip_empty_sections = 1
	let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'
	let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'
	" Configure error/warning section to use coc.nvim
	let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
	let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
	let g:airline_theme = 'solarized'

        
	
	" === nerdtree === "
	
	let g:NERDTreeShowHidden = 1
	let g:NERDTreeMinimalUI = 1
	let g:NERDTreeWinPos = 'rightbelow'
	let g:NERDTreeIgnore = ['^\.DS_Store$', '^tags$', '\.git$[[dir]]', '\.idea$[[dir]]', '\.sass-cache$']
	let g:NERDTreeStatusline = ''
	" Automaticaly close nvim if NERDTree is only thing left open
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

	" vim-devicons
	let g:webdevicons_enable = 1
	let g:webdevicons_enable_nerdtree = 1
	let g:webdevicons_enable_unite = 1
	let g:webdevicons_enable_vimfiler = 1
	let g:webdevicons_enable_airline_tabline = 1
	let g:webdevicons_enable_airline_statusline = 1
	let g:webdevicons_enable_ctrlp = 1
	let g:webdevicons_enable_flagship_statusline = 1
	let g:WebDevIconsUnicodeDecorateFileNodes = 1
	let g:WebDevIconsUnicodeGlyphDoubleWidth = 1
	let g:webdevicons_conceal_nerdtree_brackets = 1
	let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '
	let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
	let g:webdevicons_enable_denite = 1
	let g:WebDevIconsUnicodeDecorateFolderNodes = 1
	let g:DevIconsEnableFoldersOpenClose = 1
	let g:DevIconsEnableFolderPatternMatching = 1
	let g:DevIconsEnableFolderExtensionPatternMatching = 1
	let WebDevIconsUnicodeDecorateFolderNodesExactMatches = 1



        " === prettier === "
	autocmd TextChanged,InsertLeave *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

        " === coc config === "
        let g:coc_global_extensions = ["coc-css",
            \ "coc-eslint",
            \ "coc-html",
            \ "coc-json",
            \ "coc-prettier",
            \ "coc-tslint",
            \ "coc-tsserver"]


	" === Denite setup ==="
	try
	" Use ripgrep for searching current directory for files
	" By default, ripgrep will respect rules in .gitignore
	"   --files: Print each file that would be searched (but don't search)
	"   --glob:  Include or exclues files for searching that match the given glob
	"            (aka ignore .git files)
	"
	call denite#custom#var('file/rec', 'command', ['rg', '--hidden', '--files', '--glob', '!.git'])
	call denite#custom#var('grep', 'command', ['rg'])
	call denite#custom#var('grep', 'default_opts', ['--smart-case', '--follow', '--hidden', '--vimgrep', '--heading'])
	call denite#custom#var('grep', 'recursive_opts', [])
	call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
	call denite#custom#var('grep', 'separator', ['--'])
	call denite#custom#var('grep', 'final_opts', [])



	" Remove date from buffer list
	call denite#custom#var('buffer', 'date_format', '')



	" Loop through denite options and enable them
	function! s:profile(opts) abort
	  for l:fname in keys(a:opts)
	    for l:dopt in keys(a:opts[l:fname])
	      call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
	    endfor
	  endfor
	endfunction


	
	
	" Define mappings
	
	autocmd FileType denite call s:denite_my_settings()
	function! s:denite_my_settings() abort
	  nnoremap <silent><buffer><expr> <CR>
	  \ denite#do_map('do_action')
	  nnoremap <silent><buffer><expr> d
	  \ denite#do_map('do_action', 'delete')
	  nnoremap <silent><buffer><expr> p
	  \ denite#do_map('do_action', 'preview')
	  nnoremap <silent><buffer><expr> <esc>
	  \ denite#do_map('quit')
	  nnoremap <silent><buffer><expr> i
	  \ denite#do_map('open_filter_buffer')
	  nnoremap <silent><buffer><expr> <Space>
	  \ denite#do_map('toggle_select').'j'
	endfunction
	
        catch
	  echo 'Denite not installed. It should work after running :PlugInstall'
	endtry



	" === Syntastic setup === "

	set statusline+=%#warningmsg#
	set statusline+=%{SyntasticStatuslineFlag()}
	set statusline+=%*

	let g:syntastic_always_populate_loc_list = 1
	let g:syntastic_auto_loc_list = 1
	let g:syntastic_check_on_open = 1
	let g:syntastic_check_on_wq = 0



	" === Solarized Dark setup === "

	syntax enable
	set background=dark
	colorscheme solarized



" === Shortcuts === "
"
"
"

	" === Denite shorcuts === "
	"   ;         - Browser currently open buffers
	"   <leader>t - Browse list of files in current directory
	"   <leader>g - Search current directory for occurences of given term and close window if no results
	"   <leader>j - Search current directory for occurences of word under cursor
	nmap ; :Denite buffer<CR>
	"nmap <leader>t :DeniteProjectDir file/rec<CR>
	"nmap <leader>p :DeniteProjectDir file/rec -buffer-name=grep grep:::!<CR>
	nnoremap <leader>g :<C-u>DeniteProjectDir -start-filter grep:::!<CR>
	nnoremap <leader>j :<C-u>DeniteCursorWord grep:.<CR>

	nmap <leader>p :DeniteProjectDir -start-filter file/rec<CR>
        nmap <leader><Left> :bprevious<CR>
	nmap <leader><Right> :bnext<CR>


