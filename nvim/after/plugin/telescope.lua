local actions = require('telescope.actions')
local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.setup({
    defaults = {
        color_devicons = false,
        layout_config = {
            width = 0.8,
            height = 0.5,
            horizontal = {
                preview_width = 0.4
            }
        },
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<ESC>"] = actions.close,
            }
        }

    },
    pickers = {
        buffers = {
            ignore_current_buffer = true,
            sort_mru = true,
            only_cwd = false
        },
    },
})

vim.keymap.set('n', '<leader>o', builtin.find_files, {})
vim.keymap.set('n', '<leader>e', builtin.buffers, {})
vim.keymap.set('n', '<leader>f', builtin.live_grep, {})
vim.keymap.set('n', '<leader>go', builtin.git_branches, {})
vim.keymap.set('n', '<leader>s', builtin.spell_suggest, {})
