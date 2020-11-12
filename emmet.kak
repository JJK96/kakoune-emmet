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

define-command emmet-complete %{
    evaluate-commands -draft -save-regs '^"' %{
        try %{
            execute-keys -save-regs "" Z
            emmet-select-abbreviation
            execute-keys -save-regs "" yz
            evaluate-commands %sh{
                (
                snippet=$(echo "$kak_reg_dquote" | emmet -p )
                [ -z "$snippet" ] || printf "eval -client %s -save-regs '\"' %%{
                    set window emmet_completions %s.%s@%s \
                        ' |eval -draft %%{emmet-select-abbreviation;exec d};snippets-insert %%{%s}|%s (emmet abbr)'
                    }" "$kak_client" "$kak_cursor_line" "$kak_cursor_column" $(date +%N) "$snippet" "$kak_reg_dquote" | kak -p $kak_session
                ) >/dev/null 2>&1 </dev/null &
            }

        } catch %{
            set buffer emmet_completions ""
        }
    }
}

define-command emmet-enable-autocomplete %{
    set-option window completers "option=emmet_completions" %opt{completers}
    hook -group emmet-complete window InsertIdle .* emmet-complete
    alias window complete emmet-complete
}

define-command emmet-disable-autocomplete %{
    remove-hooks window emmet-.+
    set-option window completers %sh{ printf %s\\n "'${kak_opt_completers}'" | sed -e 's/option=emmet_completions://g'}
    unalias window complete emmet-complete
}
