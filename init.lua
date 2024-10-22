vim.opt.background = "dark"
vim.cmd.colorscheme("retrobox")

vim.g.mapleader = " "

vim.opt.number = true
vim.opt.colorcolumn = "80"

-- netrw settings
vim.g.netrw_banner = 0

-- autocompletion settings
vim.opt.completeopt = { "menu", "menuone", "popup", "noinsert", "noselect" }
vim.opt.pumheight = 15

-- trigger autocompletion
vim.api.nvim_create_autocmd("InsertCharPre", {
	callback = function()
		if vim.fn.pumvisible() > 0 or vim.fn.state("m") == "m" or vim.snippet.active() then
			return
		end

		local char = vim.api.nvim_get_vvar("char")
		if char:match("[a-zA-Z.^\\s]") then
			local keys = vim.api.nvim_replace_termcodes("<C-X><C-O>", true, false, true)
			vim.api.nvim_feedkeys(keys, "m", false)
		end
	end
})

-- expand snippets
-- this should only be necessary until Neovim 0.11
-- see https://github.com/neovim/neovim/pull/27339
vim.api.nvim_create_autocmd("CompleteDone", {
	callback = function()
		local completed_item = vim.api.nvim_get_vvar("completed_item")
		if not completed_item or not completed_item.user_data then
			return
		end

		if completed_item.kind == "Snippet" then
			-- Calculate the start and end positions of the inserted text
			local col = vim.fn.col(".")
			local start_col = col - #completed_item.word

			-- Delete the original word that would have been inserted
			vim.api.nvim_buf_set_text(0, vim.fn.line(".") - 1, start_col - 1, vim.fn.line(".") - 1, col - 1, {})

			vim.snippet.expand(completed_item.user_data.nvim.lsp.completion_item.insertText)
		end

		local lnum, _ = unpack(vim.api.nvim_win_get_cursor(0))
		local item = completed_item.user_data.nvim.lsp.completion_item
		local bufnr = vim.api.nvim_get_current_buf()
		if item.additionalTextEdits then
			-- Text edit in the same line would mess with the cursor position
			local edits = vim.tbl_filter(
				function(x) return x.range.start.line ~= (lnum - 1) end,
				item.additionalTextEdits
			)
			vim.lsp.util.apply_text_edits(edits, bufnr, "utf-8")
			-- Prevent an oddity where text edits can be applied twice. This clears the "v:completed_item"
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>a", true, false, true), "i", false)
		end
	end
})

-- jump between snippet slots with <Tab> when active
vim.keymap.set({ "i", "s" }, "<Tab>", function()
	if vim.snippet.active({ direction = 1 }) then
		return "<Cmd>lua vim.snippet.jump(1)<CR>"
	else
		return "<Tab>"
	end
end, { expr = true })

-- LSP keymaps
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>fo", vim.lsp.buf.format, {})
vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
