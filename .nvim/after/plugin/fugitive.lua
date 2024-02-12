vim.g.github_enterprise_urls = {'https://gitlab.com'}

vim.keymap.set("n", "<leader>gg", vim.cmd.Git)
vim.keymap.set("n", "<leader>gb", vim.cmd.GBrowse)
vim.keymap.set("n", "<leader>gp", '<CMD>Git push<CR>')
vim.keymap.set("n", "<leader>gP", '<CMD>Git pull<CR>')
vim.keymap.set("n", "<leader>gm", ":Git stash <bar> :Git checkout master <bar> :Git pull <bar> :bufdo e <CR>")