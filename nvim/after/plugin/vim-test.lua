vim.keymap.set("n", "<leader>;", vim.cmd.TestNearest)
vim.keymap.set("n", "<leader>'", vim.cmd.TestFile)
vim.keymap.set("n", "<leader>`", vim.cmd.TestSuite)

vim.g['test#strategy'] = 'neovim'
vim.g['test#neovim#start_normal'] = 1
vim.g['test#python#pytest#options'] = "-W ignore::DeprecationWarning -W ignore::FutureWarning -W ignore::PendingDeprecationWarning"