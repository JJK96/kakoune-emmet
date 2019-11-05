# Call emmet-cli with the current selection as input.
# Depends on https://github.com/Delapouite/emmet-cli
define-command emmet %{
    evaluate-commands -save-regs '"' %{
        execute-keys -save-regs "" d
        evaluate-commands %sh{
            snippet=$(echo "$kak_reg_dquote" | emmet -p )
            echo "snippets-insert %{$snippet}"
        }
    }
}

define-command emmet-select-abbreviation %{
    execute-keys <a-B><a-\;>H
}

declare-option completions emmet_completions 

hook global WinSetOption filetype=(xml|html|php) %{
    set-option window completers "option=emmet_completions" %opt{completers}
    hook -group emmet-complete buffer InsertIdle .* %{
        evaluate-commands -draft %{
            try %{
                execute-keys -save-regs "" Z
                emmet-select-abbreviation
                execute-keys -save-regs "" yz
                evaluate-commands %sh{
                    snippet=$(echo "$kak_reg_dquote" | emmet -p )
                    [ -z "$snippet" ] || printf "set window emmet_completions %s.%s@%s ' |eval -draft %%{emmet-select-abbreviation;exec d};snippets-insert %%{%s}|%s (emmet abbr)'" "$kak_cursor_line" "$kak_cursor_column" $(date +%N) "$snippet" "$kak_reg_dquote"
                }

            } catch %{
                set buffer emmet_completions ""
            }
        }
    }
    hook -once -always window WinSetOption filetype=.* %{
        remove-hooks window emmet-.+
        set-option window completers %sh{ printf %s\\n "'${kak_opt_completers}'" | sed -e 's/option=emmet_completions://g'} 
    }
}
