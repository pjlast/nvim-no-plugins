vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- treesitter syntax highlighting: https://github.com/tree-sitter/tree-sitter-go
-- run `make` and copy libtree-sitter-go.so to parser/ and the contents of queries/ to queries/go/
vim.treesitter.language.register("go", "go")
vim.treesitter.start()

-- https://github.com/golang/tools/tree/master/gopls
vim.lsp.start({
	name = "gopls",
	cmd = { "gopls" },
	root_dir = vim.fs.root(0, { "go.mod", ".git" })
})
