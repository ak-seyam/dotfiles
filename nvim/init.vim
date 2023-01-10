lua << EOL
require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'sainnhe/gruvbox-material'
    use 'nvim-treesitter/nvim-treesitter'
end)
require('nvim-treesitter.configs').setup {
    ensure_installed = { "c", "lua", "vim", "help", "bash", "fish", "javascript", "typescript", "java", "go", "fish" },
    highlight = {
        -- `false` will disable the whole extension
        enable = true,
    }
}
EOL

set tabstop=4
set shiftwidth=4
set expandtab
set termguicolors
set number
set rnu
set wrap
set showbreak=->>

let g:gruvbox_material_background = 'hard'
color gruvbox-material

