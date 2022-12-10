#!/usr/bin/env bash
# This is is a nvim bootstraping script for linux
# git, gnu core utils are required for this script it required 

set -e

############ Configuration ############
nvim_conf_path=$HOME/.config/nvim
declare -A plugins_list=(
    [tokyo_night]="https://github.com/folke/tokyonight.nvim.git" 
    [tree_sitter]="https://github.com/nvim-treesitter/nvim-treesitter.git"
    [nvim-lspconfig]="https://github.com/neovim/nvim-lspconfig.git"
    [plenary]="https://github.com/nvim-lua/plenary.nvim.git"
    [lualine]="https://github.com/nvim-lualine/lualine.nvim"
)
declare -A optional_plugins_list=(
    [telescope]="https://github.com/nvim-telescope/telescope.nvim.git"
)
nvim_plugins_dir="$nvim_conf_path/pack/$USER/start"
nvim_opt_plugins_dir="$nvim_conf_path/pack/$USER/opt"

############ Initialization ############
echo "create plugins dir"
mkdir -p $nvim_plugins_dir
mkdir -p $nvim_opt_plugins_dir

if ! command -v git &> /dev/null; then
    echo "git is required for this script, please install git"
    exit 1
fi

echo "create init file"
cat > $nvim_conf_path/init.vim << EOT
source $nvim_conf_path/general.vim
source $nvim_conf_path/view.vim
source $nvim_conf_path/plugins.vim
source $nvim_conf_path/keybindings.vim

EOT

echo "add basic config"
cat > $nvim_conf_path/general.vim << EOT
set number
set rnu
set tabstop=4
set shiftwidth=4
set expandtab
set ignorecase
set termguicolors
let g:netrw_keepdir=0

EOT

echo "create view config"
cat > $nvim_conf_path/view.vim << EOT
colorscheme tokyonight
set cursorline
set background=dark

EOT

############ Keymaps ############
cat > $nvim_conf_path/keybindings.vim << EOT
nnoremap <leader>nn :Lex 25<cr>
nnoremap <leader>ff :packadd telescope<cr>:Telescope find_files<cr>
nnoremap <leader>fg :packadd telescope<cr>:Telescope live_grep<cr>
nnoremap <leader>fb :packadd telescope<cr>:Telescope buffers<cr>
nnoremap <leader>fh :packadd telescope<cr>:Telescope help_tags<cr>
nnoremap <c-t> :tabnew 
EOT

############ Plugin installation ############
echo "install plugins"
for plugin in "${!plugins_list[@]}"; do
    if [[ ! -d "$nvim_plugins_dir/$plugin" ]]; then
        git clone ${plugins_list[$plugin]} "$nvim_plugins_dir/$plugin"
    fi
done
for plugin in "${!optional_plugins_list[@]}"; do
    if [[ ! -d "$nvim_opt_plugins_dir/$plugin" ]]; then
        git clone ${optional_plugins_list[$plugin]} "$nvim_opt_plugins_dir/$plugin"
    fi
done
############ Plugin configuration ############
echo "create plugins config"
cat > $nvim_conf_path/plugins.vim << EOT
lua << EOF
require('lualine').setup {
    options = {
        component_separators = {},
        section_separators = {},
    },
    sections = {
        lualine_x = {'encoding', 'filetype'},
    }
}

require("nvim-treesitter.configs").setup {
    ensure_installed = { 'lua', 'bash', 'fish', 'java', 'go' },
    highlight = {
        enable = true,
    },
}
EOF
EOT

