vim.keymap.set("n", "<C-e>", vim.cmd.Ex)
vim.keymap.set("n", "<leader>w", vim.cmd.w)
vim.keymap.set("n", "<leader>q", vim.cmd.q)
vim.keymap.set("n", "<leader>l", vim.cmd.LspZeroFormat)


-- Allows opening of signature_help in insert more
vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help)

-- Useful for opening test failures
vim.keymap.set("n", "gf", "gF <bar> :on <CR>")

vim.keymap.set("n", "<C-c>", vim.cmd.Commentary)
vim.keymap.set("v", "<C-c>", ":'<,'>Commentary <CR>")
vim.keymap.set("n", "§", "<Esc>")
vim.keymap.set("v", "§", "<Esc>")
vim.keymap.set("i", "§", "<Esc>")

vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "gj", "j")
vim.keymap.set("n", "gk", "k")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
-- vim.keymap.set("n", "<C-W>w", "<C-W>w <bar> <C-W>_")
