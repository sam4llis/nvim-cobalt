# nvim-cobalt

A simple plugin for alternating text in treesitter nodes.


## Experimental

This is an experimental plugin that only works with Python files at the moment.
There are no plans to add to this plugin beyond its current state, unless any
new ideas or features are useful.


## Getting started

`nvim-cobalt` requires [Neovim (v0.7.0)] or the latest [Neovim (Nightly)] to
work.


### Installation

You can install this plugin with your favourite package manager. As an example,
for [vim-plug]:

```vim
Plug 'sam4llis/nvim-cobalt'
```


### Required dependencies

* [nvim-treesitter].


## Usage

There is no setup required inside your Neovim configuration for `nvim-cobalt` to
work. Cobalt provides `:CAlternate` to alternate text inside Python files. By
default, `True` alternates to `False`, and `''` alternates to `f''`. These
mappings also operate in reverse.

Simply call `:CAlternate`, or `:CA`, inside a `true`, `false`, or `string`
treesitter node to alternate the node text. The cursor position when calling
`:CAlternate` is also preserved.


[Neovim (Nightly)]: https://github.com/neovim/neovim/releases/tag/nightly
[Neovim (v0.7.0)]: https://github.com/neovim/neovim/releases/tag/v0.7.0
[nvim-treesitter]: https://github.com/nvim-treesitter/nvim-treesitter
[vim-plug]: https://github.com/junegunn/vim-plug
