function fish_user_key_bindings
    bind -M insert \cf fzf_search
    bind -M default \cf fzf_search
end

# my functions
function fzf_search
    set s_cmd $(ls /usr/bin/ /usr/local/bin/ /bin /usr/share/applications | sed '/^\//d' | sed '/^[[:space:]]*$/d' | fzf --reverse --height=10)
    if string match -e '.desktop' $s_cmd
        commandline --replace "gtk-launch $s_cmd"
    else if not test -z $s_cmd 
        commandline --replace $s_cmd
    end
    commandline --function repaint
end
