vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Neovim has a treesitter parser for lua built in
vim.treesitter.start()

-- https://github.com/LuaLS/lua-language-server
vim.lsp.start({
	name = "lua-language-server",
	cmd = { "lua-language-server" },
	root_dir = vim.fs.root(0, { "init.lua" }),
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT'
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME
				}
			}
		}
	}
})
