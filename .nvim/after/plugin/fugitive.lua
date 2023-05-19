vim.g.github_enterprise_urls = {'https://github.com'}

vim.keymap.set("n", "<leader>gg", vim.cmd.Git)
vim.keymap.set("n", "<leader>gb", vim.cmd.GBrowse)
vim.keymap.set("n", "<leader>gp", '<CMD>Git push<CR>')