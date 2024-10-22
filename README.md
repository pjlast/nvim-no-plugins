# Neovim config without any plugins

Experimental Neovim config that doesn't use any external plugins.

The idea of this setup is to use Neovim as a toolbox and get comfortable
with your Lua config to glue different tools together.

## Goals

It should offer the following:

1. Autocompletion
2. LSP integration
3. Syntax highlighting
4. A way to fuzzy-find files in a project
5. A way to search for code snippets in a project (i.e. grep)

## Try it out

Trying it out should be straightforward:

```
cd ~/.config
git clone git@github.com:pjlast/nvim-no-plugins
NVIM_APPNAME=nvim-no-plugins nvim
```
