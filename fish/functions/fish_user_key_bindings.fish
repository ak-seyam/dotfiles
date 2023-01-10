function fish_user_key_bindings
    bind -M insert \cf fzf_search
    bind -M default \cf fzf_search
    bind -M insert \cr fzf_manual
    bind -M default \cr fzf_manual
    bind -M insert \cn fzf_config
    bind -M default \cn fzf_config
end

alias fzf_inline="fzf --reverse --height=10"

# my functions
function fzf_search
    set s_cmd $(ls /usr/bin/ /usr/local/bin/ /bin /usr/share/applications | sed '/^\//d' | sed '/^[[:space:]]*$/d' | awk '!a[$0]++' | fzf_inline)
    if string match -e '.desktop' $s_cmd
        commandline --replace "gtk-launch $s_cmd"
    else if not test -z $s_cmd 
        commandline --replace $s_cmd
    end
    commandline --function repaint
end

function fzf_manual
    set s_cmd $(ls /usr/bin/ /usr/local/bin/ /bin /usr/share/applications | sed '/^\//d' | sed '/^[[:space:]]*$/d' | awk '!a[$0]++' | fzf_inline)
    if not test -z $s_cmd 
        man $s_cmd
    end
    commandline --function repaint
end

function fzf_config
    set s_dir $(ls $HOME/.config | fzf_inline)
    cd $HOME/.config/$s_dir
    commandline --function repaint
end
