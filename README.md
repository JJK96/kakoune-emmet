# Emmet.kak

A wrapper around [emmet-cli](https://github.com/Delapouite/emmet-cli) that uses [kakoune-snippets](https://github.com/occivink/kakoune-snippets) to process the snippets.

## Setup

Make sure `emmet` is in your path

Load `emmet.kak` either manually or using [plug.kak](https://github.com/andreyorst/plug.kak)

## Dependencies

- [emmet-cli](https://github.com/Delapouite/emmet-cli)
- [kakoune-snippets](https://github.com/occivink/kakoune-snippets)

## Usage

### Manual

1. Enter a [valid emmet abbreviation](https://docs.emmet.io/abbreviations/syntax) into the buffer.
2. Select it.
3. run `:emmet`

You can also create mappings for ease of use, some examples:

To expand the current line:

`map global insert <a-e> "<esc>x: emmet<ret>"`

### Completer

You can enable the emmet completer by running `emmet-enable-autocomplete`

Upon selecting an emmet completion the snippet is inserted
