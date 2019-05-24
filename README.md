I used [emmet-cli](https://github.com/Delapouite/emmet-cli) and [kakoune-snippets](https://github.com/occivink/kakoune-snippets) to make a completer that inserts an emmet snippet upon selection.

What works:

- Filling the completions
- Selecting (and thus applying) a snippet

What needs more work:

- When mixed with other completions, the emmet completions disappear
- Has a noticeable impact on fluency of the editor due to all the requests to emmet. Maybe it would be better to make a regex that already contains all possible emmet commands, so that no calls to emmet are needed except for inserting a snippet.
- There is no support ATM for more elaborate emmet commands (e.g. `ul>li*5`). These can be inserted manually using the `:emmet` command though.
