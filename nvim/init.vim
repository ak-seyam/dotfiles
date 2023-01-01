set number
set rnu
set tabstop=4
set shiftwidth=4
set expandtab
set ignorecase
set background=dark
set termguicolors
set wrap
set showbreak=->>
set autoindent
set smartindent

let g:gruvbox_material_background = 'hard'
color gruvbox-material

lua << EOL
require'nvim-treesitter.configs'.setup {
      ensure_installed = {"fish", "go", "java", "lua", "bash"},
      highlight = {
          enable = true, 
      }
}
EOL
