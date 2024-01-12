function fish_prompt --description 'Write out the prompt'
    set -l laststatus $status

    set -l git_info
    if set -l git_branch (command git symbolic-ref HEAD 2>/dev/null | string replace refs/heads/ '')
        set git_branch (set_color 00d7ff)"$git_branch"
        set -l git_status
        if not command git diff-index --quiet HEAD --
            if set -l count (command git rev-list --count --left-right $upstream...HEAD 2>/dev/null)
                echo $count | read -l ahead behind
                if test "$ahead" -gt 0
                    set git_status "$git_status"(set_color red)⬆
                end
                if test "$behind" -gt 0
                    set git_status "$git_status"(set_color red)⬇
                end
            end
            for i in (git status --porcelain | string sub -l 2 | sort | uniq)
                switch $i
                    case "."
                        set git_status "$git_status"(set_color af00ff)✚
                    case " D"
                        set git_status "$git_status"(set_color red)✖
                    case "*M*"
                        set git_status "$git_status"(set_color af00ff)"*"
                    case "*R*"
                        set git_status "$git_status"(set_color 005fff)➜
                    case "*U*"
                        set git_status "$git_status"(set_color brown)═
                    case "??"
                        set git_status "$git_status"(set_color red)≠
                end
            end
        else
            set git_status (set_color green):
        end
        set git_info " $git_status$git_branch"(set_color white)
    end

    # Disable PWD shortening by default.
    set -q fish_prompt_pwd_dir_length
    or set -lx fish_prompt_pwd_dir_length 0

    printf '%s%s%s%s%s%s%s%s%s%s%s%s%s' (set_color ffa000) $USER ' ' (set_color white) $PWD (set_color white) $git_info (set_color white)
    if test $laststatus -eq 0
        printf "%s✔%s " (set_color -o green) (set_color normal)
    else
        printf "%s✘%s " (set_color -o red) (set_color normal)
    end
end
